//
//  ViewController.swift
//  OmarJSON
//
//  Created by Serxhio Gugo on 1/9/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate, UIScrollViewDelegate {

    let jsonURL = "https://shopicruit.myshopify.com/admin/custom_collections.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6&fbclid=IwAR2maQdP5nrr0aqiJrS5ZujsX2AW9mt7y6YawdK5xB1g2qHfo7dhMv4nUtA"
    var customCollections = [CustomCollection]()
    var currentCustomCollections = [CustomCollection]()
    let cellId = "cellId"
    let leadingScreensForBatching: CGFloat = 2.185
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        collectionView.keyboardDismissMode = .onDrag
        view.backgroundColor = .white
        setupUI()
        setupNavController()
        
        //Need to specify dispatch.async here with completion for task
        fetchJSON(url: jsonURL) { (response, error) in
            guard let item = response?.customCollections else { return }
            self.customCollections = item
            self.currentCustomCollections = self.customCollections
            
            self.collectionView.reloadData()
        }
        

    }
    
    let searchBar: UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width / 2.5, height: 20))

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    //Setting up the navigationBar
    private func setupNavController() {
        view.backgroundColor = .white
        navigationItem.title = "Collections"
        navigationController?.navigationBar.barTintColor =  #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        navigationController?.navigationBar.prefersLargeTitles = true
        let attributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        navigationController?.navigationBar.largeTitleTextAttributes = attributes
        navigationController?.navigationBar.titleTextAttributes = attributes
        navigationController?.navigationBar.tintColor = .white
        
        
        
        
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("View is scrolling")
        
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.size.height * leadingScreensForBatching {
            searchBar.isHidden = false
            let leftNavBarButton = UIBarButtonItem(customView: searchBar)
            navigationItem.rightBarButtonItem = leftNavBarButton
            searchBar.placeholder = "Search..."
            searchBar.delegate = self
        }else {
            searchBar.isHidden = true
        }
        
    }
    
    //This is used to make the status bar white
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: CollectionView
    lazy var collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
       layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor(red: 132, green: 179, blue: 255, alpha: 1)
        
        //If we declare the collectionView property as a lazy var, it allows access to set the delegates here and also register our custom cell, so we keep viewDidLoad a little cleaner
        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        return collectionView
    }()
    
    private func setupUI() {
        view.addSubview(collectionView)
        
        //this allows you to put as many constraints in here as you need, even if you have other elements, and you don't need to .isActive = true anymore
        NSLayoutConstraint.activate([
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.9),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: ((UIApplication.shared.keyWindow?.safeAreaInsets.top)! + 40))
            ])
        collectionView.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
    }
    
    //MARK: Setting up the search bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            currentCustomCollections = customCollections
            collectionView.reloadData()
            return
        }
        currentCustomCollections = customCollections.filter({city -> Bool in
            city.title!.lowercased().contains(searchText.lowercased())
        })
        collectionView.reloadData()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        collectionView.reloadData()
        collectionView.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        collectionView.reloadData()
    }
    
    //MARK: NetworkRequest
    func fetchJSON(url: String, completion: @escaping (JSONResponse?, Error?) -> Void) {
        guard let url = URL(string: url) else { return }
        
        //Look at difference of URLSession types and why "shared" is used here
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                print("Unable to fetch data", error)
                let alert = UIAlertController(title: "Error", message:"Unable to Retrive the data!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            guard let data = data else { return }
            do {
                let response = try JSONDecoder().decode(JSONResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(response, nil)
                }
            } catch let jsonError{
                let alert = UIAlertController(title: "Error", message:"Unable to Retrive the data!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                print("Unable to decode: ", jsonError)
            }
        }
        dataTask.resume()
    }
}


//I worked with collectionView's protocols in an extension just so they can be separate, easier to get to
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentCustomCollections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CustomCollectionViewCell
        
        var collectionName = currentCustomCollections[indexPath.item].title
        collectionName = collectionName?.replacingOccurrences(of: "collection", with: "")
        
        cell.nameLabel.text = collectionName
        cell.layer.cornerRadius = 25
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width * 0.7, height: UIScreen.main.bounds.height * 0.1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 5, bottom: 20, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var collectionName = currentCustomCollections[indexPath.item].title
        collectionName = collectionName?.replacingOccurrences(of: "collection", with: "")
        //Passed the variable to the other controller
        let productsController = ProductViewController()
        productsController.collectID = currentCustomCollections[indexPath.item].id
        productsController.bodyHTML = currentCustomCollections[indexPath.item].bodyHTML
        productsController.collectName = collectionName
        productsController.collectionImage = currentCustomCollections[indexPath.item].image?.src
//        self.present(productsController, animated: true, completion: nil)
        navigationController?.pushViewController(productsController, animated: true)
        
        
    }
}

