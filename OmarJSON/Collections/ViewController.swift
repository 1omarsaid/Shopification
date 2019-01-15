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
        view.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        //Setting up the user interface in the viewDidLoad
        setupUI()
        setupNavController()
        collectionView.showsVerticalScrollIndicator = false
        //Fetching the JSON from the first URL
        fetchJSON(url: jsonURL) { (response, error) in
            //Setting up the item to the response struct
            guard let item = response?.customCollections else { return }
            self.customCollections = item
            self.currentCustomCollections = self.customCollections
            
            self.collectionView.reloadData()
        }
        
        //Check if there is internet Connectivity
        if !(Reachability.isConnectedToNetwork()) {
            let alert = UIAlertController(title: "Error", message:"You need to enable location services to make a Post! Enable location services in settings", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
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
    
    //Creting a function that will trigger when scrolling occurs
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //Creating references to the screen
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        //Setting up constraints to show the search bar if the screen has scrolled enoough to dismiss the large tile
        //Of the navigation controller
        if offsetY > contentHeight - scrollView.frame.size.height * leadingScreensForBatching {
            //showing the searchBar if it is passed the scrolling position of the large navigationbar
            searchBar.isHidden = false
            let leftNavBarButton = UIBarButtonItem(customView: searchBar)
            navigationItem.rightBarButtonItem = leftNavBarButton
            searchBar.placeholder = "Search..."
            searchBar.delegate = self
        }else {
            searchBar.isHidden = true
        }
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
    
    //Setting up the user interface
    private func setupUI() {
        view.addSubview(collectionView)
        //Setting up the constraints for the collectin View
        NSLayoutConstraint.activate([
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
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
        //Filtering the customCollections array with the collection's title
        currentCustomCollections = customCollections.filter({collection -> Bool in
            collection.title!.lowercased().contains(searchText.lowercased())
        })
        //Reloading the collectionview after the filtering has been made
        collectionView.reloadData()
    }
    
    //This is used to dismiss the keyboard when the search button is clicked
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        collectionView.reloadData()
    }
    
    //MARK: NetworkRequest- fetching the JSON data
    func fetchJSON(url: String, completion: @escaping (JSONResponse?, Error?) -> Void) {
        guard let url = URL(string: url) else { return }
        
        //Initializing our serrion
        let session = URLSession.shared
        //Creating a task
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            //Checking to see if an error occured and giving a popup alert
            if let error = error {
                completion(nil, error)
                print("Unable to fetch data", error)
                let alert = UIAlertController(title: "Error", message:"Unable to Retrive the data!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            //Checking to see if there is data aquired
            guard let data = data else { return }
            do {
                //Decoding the json data
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
        //Starting the task
        dataTask.resume()
    }
}


//I worked with collectionView's protocols in an extension just so they can be separate, easier to get to
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //setting up the collectionview number to the filtered array
    //However if its not filtered then it will show the count of the whole call
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentCustomCollections.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //declaring the cell with the custom one that was made in CustomCollectionViewCell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CustomCollectionViewCell
        //stating the collection name to the collection's title
        var collectionName = currentCustomCollections[indexPath.item].title
        //Removing the "Collection's" phrase so its not excesive
        collectionName = collectionName?.replacingOccurrences(of: "collection", with: "")
        //Specifying the name label (in the cell) to the new collection name
        cell.nameLabel.text = collectionName
        //Creating a corner radium for the cell to make it look better
        cell.layer.cornerRadius = 25
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //Specifying the size of the cell
        return CGSize(width: UIScreen.main.bounds.width * 0.7, height: UIScreen.main.bounds.height * 0.1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        //Specifying the insets of the collectionView
        return UIEdgeInsets(top: 20, left: 5, bottom: 20, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //Recaling the collection name and editing it before sending it to the next view
        var collectionName = currentCustomCollections[indexPath.item].title
        collectionName = collectionName?.replacingOccurrences(of: "collection", with: "")
        //Created an instance of the product view controller to pass the data
        let productsController = ProductViewController()
        //The collectID variable is set to the collection's ID
        productsController.collectID = currentCustomCollections[indexPath.item].id
        //The bodyHTML variable is set to the collection's body_HTML
        productsController.bodyHTML = currentCustomCollections[indexPath.item].bodyHTML
        //The collect's varialbe is set to the modified collection name
        productsController.collectName = collectionName
        //The collectionImage variable is set to the image source
        productsController.collectionImage = currentCustomCollections[indexPath.item].image?.src
        //Presenting the view controller with a "Push" to keep the navigation bar
        navigationController?.pushViewController(productsController, animated: true)
    }
}

