//
//  ProductCollectionViewCell.swift
//  OmarJSON
//
//  Created by omar on 2019-01-10.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //Created an array of Variants that will be used in the picker view to display its contents
    var dataSource = [Variant]()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //Setting up the background color of the cell as white to match the main view
        backgroundColor = .white
        //Setting up the User interface
        setupUI()
        pickerView.selectRow(0, inComponent: 0, animated: true)
    }
    
    //Created a picker view programatically that will display the inventory
    lazy var pickerView: UIPickerView={
        let pv = UIPickerView()
        pv.translatesAutoresizingMaskIntoConstraints = false
        pv.delegate = self
        pv.dataSource = self
        pv.showsSelectionIndicator = true
        pv.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        pv.layer.cornerRadius = 5
        return pv
    }()
    
    //Created a name label that will be used to display the name of the products
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()
    
    let outOfLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        label.text = "3/3"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()
    
    //Created an inventory label that will sit ontop of the picker view
    let inventoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Inventory(Color: Quanitity)"
        label.textColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    //Collection Label used to display the name of the collections.
    let collectionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        return label
    }()
    
    //An image that will be used to present the image of the collection
    let productImage : UIImageView = {
        var userImage = UIImageView()
        userImage.layer.masksToBounds = true
        userImage.backgroundColor = .clear
        userImage.layer.borderColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        userImage.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        userImage.layer.borderWidth = 3.0
        userImage.layer.cornerRadius = 20
        userImage.clipsToBounds =  true
        userImage.contentMode = .scaleAspectFit
        userImage.translatesAutoresizingMaskIntoConstraints = false
        return userImage
    }()
    
    //Function used to set up the user interface (setting up the constraints)
    private func setupUI() {
        addSubview(nameLabel)
        addSubview(productImage)
        addSubview(collectionLabel)
        addSubview(pickerView)
        addSubview(inventoryLabel)
        addSubview(outOfLabel)
        //This is where we set the constraints
        NSLayoutConstraint.activate([
            
            //Need x, y, width and height contraints
            //Image constraints
            productImage.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            productImage.centerYAnchor.constraint(equalTo: topAnchor, constant: UIScreen.main.bounds.height * 0.07),
            productImage.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.13),
            productImage.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.13),
            
            //Name Label Constraints
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: productImage.bottomAnchor, constant: UIScreen.main.bounds.height * 0.03),
            nameLabel.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.05),
            nameLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.7),
            
            //Out of label constraints
            outOfLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: UIScreen.main.bounds.width * -0.07),
            outOfLabel.topAnchor.constraint(equalTo: topAnchor, constant: UIScreen.main.bounds.height * 0.02),
            outOfLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.08),
            outOfLabel.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.08),
        
            
            //Collection Label constraints
            collectionLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            collectionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: UIScreen.main.bounds.height * -0.025),
            collectionLabel.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.05),
            collectionLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width  * 0.7),
            
            //Inventory label constraints
            inventoryLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            inventoryLabel.topAnchor.constraint(equalTo: collectionLabel.bottomAnchor, constant: UIScreen.main.bounds.height * 0),
            inventoryLabel.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.03),
            inventoryLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width  * 0.9),
            
            //Picker view constraints
            pickerView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            pickerView.topAnchor.constraint(equalTo: inventoryLabel.bottomAnchor, constant: UIScreen.main.bounds.height * 0),
            pickerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: UIScreen.main.bounds.height * -0.02),
            pickerView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width  * 0.7)
            ])
    }
    
    //This will set the number for picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //Using the datasource (an array of variants) count as the number of rows.
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataSource.count
    }

    //setting up the title of the picker views at certain rows
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //Checking to make sure we dont fall out of the index
        if row < dataSource.count {
            //Returning the variant's title and the inventory numebers as the title in the row
            return "\(dataSource[row].title): \(dataSource[row].inventoryQuantity)"
        } else {
            return nil
        }
    }
    
    //This is required but nobody ever uses it,
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
