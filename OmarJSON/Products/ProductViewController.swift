//
//  ProductViewController.swift
//  OmarJSON
//
//  Created by omar on 2019-01-10.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {

    //Collect ID used query the last URL
    var collectID: Int!
    //The collection name that will be used in the collection view cells
    var collectName: String!
    //Collection image url that will be used to display in the collection view cells
    var collectionImage: String!
    //Body HTML will talk about the description of the collection
    var bodyHTML: String!
    //This is the image that will be in the collection view cells representing the collection's imge
    var imageProduct: UIImage!
    
    //This will be used to collect the id's for the products
    var collects = [Collect]()
    //Creating a temporary string that will be used to obtain all the collec ID's
    var collectionCollects = ""
    //This will have the products
    var products = [Product]()
    //This will have the variants
    var varients = [Variant]()
    //The cell ID for the cells
    let cellId = "cellid"
    
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        //Setting up the navigationBar
        setupNavController()
        //Setting up the user interface
        setupUI()
        //Setting up the background color to match the main view
        view.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        //Using string intorpelation to get the new JSON data
        let jsonURL = "https://shopicruit.myshopify.com/admin/collects.json?collection_id=\((collectID)!)&page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6"
        
        
        //WInitially we need to fetch the collects to build the final URL
        fetchJSON(url: jsonURL) { (response, error) in
            guard let item = response?.collects else { return }
            self.collects = item
            //Creating a for loop that will go through every collect and add the tup
            for i in self.collects {
                //This will put all the id's together seperated by comma
                self.collectionCollects.append(",")
                self.collectionCollects.append(String(i.productID))
            }
            
            //This will remove the first comma in the string
            self.collectionCollects.remove(at: self.collectionCollects.startIndex)

            //This is the productURL that we will use to retrieve the products and put them in the collectionView
            let productURL = "https://shopicruit.myshopify.com/admin/products.json?ids=\(self.collectionCollects)&page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6"
            
            //This will detch the products with the new URL
            self.fetchProducts(url: productURL) { (response, error) in
                guard let item = response?.products else {return}
                self.products = item
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
                //Specifying Alert to show user that image can not be downloaded at this time
                let alert = UIAlertController(title: "Error", message:"Image can not be loaded at this time", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
     setupExtraComponent()
        
    }
    
    //This function is used to set up the card view that displays the collection's html as well as its image and title
    func setupExtraComponent() {
        //Creating the detailed view that will be at the top of the screen
        let detailView = UIView()
        //Resizing the view if the collection's text is empty of has data in it
        if bodyHTML == "" {
            detailView.frame = CGRect(x: 0, y: UIScreen.main.bounds.height * 0.12, width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.1)
        }else {
            detailView.frame = CGRect(x: 0, y: UIScreen.main.bounds.height * 0.12, width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.15)
        }
        
        //Specifying the detail view to be white to match the current user interface layout
        detailView.backgroundColor = .white
        //creating a corner radius to make it look better
        detailView.layer.cornerRadius = 40
        //Centering the collection view with respect to the main view
        detailView.center.x = view.center.x
        //Add the detailed view to the main view
        view.addSubview(detailView)
        
        //Creating a lable to shwot the collection's name
        let detailLabel = UILabel(frame: CGRect(x: 0 , y: detailView.frame.height * 0.1, width: detailView.frame.width * 0.5 , height: detailView.frame.height * 0.34))
        detailLabel.textAlignment = .center
        detailLabel.text = "\((collectName)!)"
        detailLabel.numberOfLines = 0
        detailLabel.textAlignment = .center
        detailLabel.textColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        detailLabel.font = UIFont.boldSystemFont(ofSize: 25)
        
        //Centering the detailed label's horizontal axis center with respect to the detailed view
        detailLabel.center.x = detailView.center.x
        
        //Creating an image that will have the collection's image
        let detailImage = UIImageView()
        detailImage.image = imageProduct
        detailImage.contentMode = .scaleToFill
        detailImage.layer.cornerRadius = 10
        detailImage.translatesAutoresizingMaskIntoConstraints = false
        
        //Creating a detail's text that will hold the HTML of the collects
        let detailText = UILabel(frame: CGRect(x: 0 , y: detailView.frame.height * 0.35 , width: detailView.frame.width * 0.6 , height: detailView.frame.height * 0.7))
        detailText.textAlignment = .left
        detailText.text = "\((bodyHTML)!)"
        detailText.numberOfLines = 0
        detailText.sizeToFit()
        detailText.textColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        detailText.font = UIFont.boldSystemFont(ofSize: 15)
        
        //Centering the detailed text horizontal axis center with respect to the detailed view
        detailText.center.x = detailView.center.x
        
        //Adding the objects to the detail view
        detailView.addSubview(detailLabel)
        detailView.addSubview(detailImage)
        detailView.addSubview(detailText)
        
        //Setting up constraints for the detail image in a dynamic manner so it will look the same on different devices
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
        //Adding the collection view to the main view
        view.addSubview(collectionView)
        
        //This is used to set up the constraints for the collection View
        NSLayoutConstraint.activate([
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: UIScreen.main.bounds.height * 0.3),
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
        }
    
    
    //MARK: This function is used to fetch the collects data
    func fetchJSON(url: String, completion: @escaping (Collects?, Error?) -> Void) {
        //Making sure that a url exists
        guard let url = URL(string: url) else { return }
        //Creating a session
        let session = URLSession.shared
        //Creating a task
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            //Checking to see if there is an error
            if let error = error {
                completion(nil, error)
                //Creating a pop up alerts to display the error
                let alert = UIAlertController(title: "Error", message:"Unable to Retrive the data!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                print("Unable to fetch data", error)
            }
            //Checking to see if the data exists
            guard let data = data else { return }
            do {
                //Decoding the JSON data
                let response = try JSONDecoder().decode(Collects.self, from: data)
                DispatchQueue.main.async {
                    completion(response, nil)
                }
            } catch let jsonError{
                print("Unable to decode: ", jsonError)
            }
        }
        //Starting the task
        dataTask.resume()
    }
    
    
    //MARK: This function is used to fetch the Products data
    func fetchProducts(url: String, completion: @escaping (Products?, Error?) -> Void) {
        //Making sure that a url exists
        guard let url = URL(string: url) else { return }
        //Creating a session
        let session = URLSession.shared
        //Creating a task
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            //Checking to see if there is an error
            if let error = error {
                completion(nil, error)
                //Creating a pop up alerts to display the error
                let alert = UIAlertController(title: "Error", message:"Unable to Retrive the data!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                print("Unable to fetch data", error)
            }
            //Checking to see if the data exists
            guard let data = data else { return }
            do {
                //Decoding the JSON data
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
    
}


//Setting up the collectionView extensions seperate
extension ProductViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    //Setting up the number of items as the prodocuts array's coutn
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }

    //
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //Declaring the cell with the custom one that was made in ProductCollectionViewCell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ProductCollectionViewCell
        //Setting up the product's name with the title
        var productName = products[indexPath.item].title
        //Editing the product's name to remove the collection's name in the beginning
        productName = productName.replacingOccurrences(of: "\((collectName)!)", with: "")
        //specifying the cell's name label as the edited product name
        cell.nameLabel.text = productName
        //Setting the product's image as the collection's image
        cell.productImage.image = imageProduct
        //Passing data for our collection's image
        cell.collectionLabel.text = "Collection: \((collectName)!)"
        //Specifying the corner radius to make the cell rounded
        cell.layer.cornerRadius = 10
        //Passing the variant's array to the datasource array in the cell
        cell.dataSource = products[indexPath.item].variants
        return cell
    }

    
    //Specifying the cell's size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 300)
    }

    //Speficying the insets of the collection cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }

}
