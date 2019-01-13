//
//  ProductViewController.swift
//  OmarJSON
//
//  Created by omar on 2019-01-10.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {

    var collectID: Int!
    var collectName: String!
    var collectionImage: String!
    var bodyHTML: String!
    var imageProduct: UIImage!
    //This will be used to collect the id's for the products
    var collects = [Collect]()
    var collectionCollects = ""
    //This will have the products
    var products = [Product]()
    //This will have the variants
    var varients = [Variant]()
    let cellId = "cellid"
    
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        //Setting up the navigationBar
//        setNavigationBar()
        setupNavController()
        //Using string interpolation for the URL
        setupUI()
        
        view.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        let jsonURL = "https://shopicruit.myshopify.com/admin/collects.json?collection_id=\((collectID)!)&page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6"
        
        
        //We need to first fetch the collects
        fetchJSON(url: jsonURL) { (response, error) in
            guard let item = response?.collects else { return }
            self.collects = item
            for i in self.collects {
                //This will put all the id's together
                self.collectionCollects.append(",")
                self.collectionCollects.append(String(i.productID))
            }
            
            //This will remove the first comma in the string
            self.collectionCollects.remove(at: self.collectionCollects.startIndex)

            //This is the productURL that we will use to retrieve the products and put them in the collectionView
            let productURL = "https://shopicruit.myshopify.com/admin/products.json?ids=\(self.collectionCollects)&page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6"
            self.fetchProducts(url: productURL) { (response, error) in
                guard let item = response?.products else {return}
                self.products = item
                self.collectionView.reloadData()

                self.collectionView.reloadData()
            }
          
        }
        //Using the URL to get the image
        let url = URL(string: "\((collectionImage)!)")
        
        if let data = try? Data(contentsOf: url!)
        {
            imageProduct = UIImage(data: data)
        }
        
        //Specify a background thread for the work
        DispatchQueue.global(qos: .background).async {
            do
            {
                let data = try Data.init(contentsOf: URL.init(string:"url")!)
                DispatchQueue.main.async {
                    self.imageProduct = UIImage(data: data)
                }
            }
            catch {
                // error
            }
        }
        
     setupExtraComponent()
        
    }
    
    //This function is used to set up the card view that displays the collection's html as well as its image and title
    func setupExtraComponent() {
        let detailView = UIView()
        if bodyHTML == "" {
            detailView.frame = CGRect(x: 0, y: UIScreen.main.bounds.height * 0.12, width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.1)
        }else {
            detailView.frame = CGRect(x: 0, y: UIScreen.main.bounds.height * 0.12, width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.15)
            
        }
        detailView.backgroundColor = .white
        detailView.layer.cornerRadius = 40
        detailView.center.x = view.center.x
        
        view.addSubview(detailView)
        
        
        let detailLabel = UILabel(frame: CGRect(x: 0 , y: detailView.frame.height * 0.1, width: detailView.frame.width * 0.5 , height: detailView.frame.height * 0.34))
        detailLabel.textAlignment = .center
        detailLabel.text = "\((collectName)!)"
        detailLabel.numberOfLines = 0
        detailLabel.textAlignment = .center
        detailLabel.textColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        detailLabel.font = UIFont.boldSystemFont(ofSize: 25)
        
        detailLabel.center.x = detailView.center.x
        
        let detailImage = UIImageView()
        detailImage.image = imageProduct
        detailImage.contentMode = .scaleToFill
        detailImage.layer.cornerRadius = 10
        detailImage.translatesAutoresizingMaskIntoConstraints = false
        
        
        let detailText = UILabel(frame: CGRect(x: 0 , y: detailView.frame.height * 0.35 , width: detailView.frame.width * 0.6 , height: detailView.frame.height * 0.7))
        detailText.textAlignment = .left
        detailText.text = "\((bodyHTML)!)"
        detailText.numberOfLines = 0
        detailText.sizeToFit()
        detailText.textColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        detailText.font = UIFont.boldSystemFont(ofSize: 15)
        
        detailText.center.x = detailView.center.x
        
        detailView.addSubview(detailLabel)
        detailView.addSubview(detailImage)
        detailView.addSubview(detailText)
        
        detailImage.leftAnchor.constraint(equalTo: detailView.leftAnchor, constant: UIScreen.main.bounds.width * 0.05).isActive = true
        detailImage.topAnchor.constraint(equalTo: detailView.topAnchor, constant: UIScreen.main.bounds.width * 0.05).isActive = true
        detailImage.heightAnchor.constraint(equalToConstant: detailView.frame.height * 0.5).isActive = true
        detailImage.widthAnchor.constraint(equalToConstant: detailView.frame.height * 0.5).isActive = true
    }
    
    //This function is used to set up the attributes of the navigation controller
    private func setupNavController() {
        view.backgroundColor = .white
        navigationItem.title = "Collections"
        navigationController?.navigationBar.barTintColor =  #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        navigationController?.navigationBar.prefersLargeTitles = false
        let attributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        navigationController?.navigationBar.largeTitleTextAttributes = attributes
        navigationController?.navigationBar.titleTextAttributes = attributes
    }
    
    
    //This is used to make the status bar white
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //This function is used to set up the constraints for the collectionView
    private func setupUI() {
        view.addSubview(collectionView)
        
        //this allows you to put as many constraints in here as you need, even if you have other elements, and you don't need to .isActive = true anymore
        NSLayoutConstraint.activate([
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: UIScreen.main.bounds.height * 0.3),
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
            }
    
    
    //MARK: This function is used to fetch the collects data
    func fetchJSON(url: String, completion: @escaping (Collects?, Error?) -> Void) {
        guard let url = URL(string: url) else { return }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                
                let alert = UIAlertController(title: "Error", message:"Unable to Retrive the data!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                print("Unable to fetch data", error)
            }
            guard let data = data else { return }
            do {
                let response = try JSONDecoder().decode(Collects.self, from: data)
                DispatchQueue.main.async {
                    completion(response, nil)
                }
            } catch let jsonError{
                print("Unable to decode: ", jsonError)
            }
        }
        dataTask.resume()
    }
    
    
    //MARK: This function is used to fetch the Products data
    func fetchProducts(url: String, completion: @escaping (Products?, Error?) -> Void) {
        guard let url = URL(string: url) else { return }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                let alert = UIAlertController(title: "Error", message:"Unable to Retrive the data!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                print("Unable to fetch data", error)
            }
            guard let data = data else { return }
            do {
                let response = try JSONDecoder().decode(Products.self, from: data)
                DispatchQueue.main.async {
                    completion(response, nil)
                }
            } catch let jsonError{
                
                print("Unable to decode: ", jsonError)
            }
        }
        dataTask.resume()
    }

    

    
    //MARK: CollectionView
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        
        //If we declare the collectionView property as a lazy var, it allows access to set the delegates here and also register our custom cell, so we keep viewDidLoad a little cleaner
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        return collectionView
    }()
    
    
    //Lets create a dismiss button in a navigation controller
    func setNavigationBar() {
        let screenSize: CGRect = UIScreen.main.bounds
        let window = UIApplication.shared.keyWindow
        
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: (window?.safeAreaInsets.top)!, width: screenSize.width, height: 70))
        let navItem = UINavigationItem(title: "\((collectName)!)")
        let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: nil, action: #selector(done))
        navItem.rightBarButtonItem = doneItem
        navBar.setItems([navItem], animated: false)
        self.view.addSubview(navBar)
    }
    
    
    @objc func done() {
        self.dismiss(animated: true, completion: nil)
    }


}


//Setting up the collectionView extensions seperate
extension ProductViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ProductCollectionViewCell
        
        var productName = products[indexPath.item].title
        print(products[indexPath.item].variants)
        productName = productName.replacingOccurrences(of: "\((collectName)!)", with: "")
        cell.numberofposts = products[indexPath.item].variants.count
        cell.nameLabel.text = productName
        cell.productImage.image = imageProduct
        cell.collectionLabel.text = "Collection: \((collectName)!)"
        cell.layer.cornerRadius = 10
        cell.dataSource = products[indexPath.item].variants
        return cell
    }

    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 300)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }


}
