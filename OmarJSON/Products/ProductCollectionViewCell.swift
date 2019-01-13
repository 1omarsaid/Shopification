//
//  ProductCollectionViewCell.swift
//  OmarJSON
//
//  Created by omar on 2019-01-10.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var numberofposts : Int!
    var dataSource = [Variant]()
    
    
    //think of this as your viewDidLoad ...
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupUI()
        pickerView.selectRow(0, inComponent: 0, animated: true)
        //        addSubview(inventoryLabel)
//        addSubview(collectionLabel)
//        addSubview(productImage)
    }
    
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
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()
    
    let inventoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Inventory"
        label.textColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 20)
//        label.backgroundColor = .lightGray
        label.textAlignment = .center
        return label
    }()
    
    let collectionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 15)
//        label.backgroundColor = .gray
        label.textAlignment = .center
        return label
    }()
    
    let productImage : UIImageView = {
        var userImage = UIImageView()
        userImage.layer.masksToBounds = true
        userImage.backgroundColor = .clear
        userImage.layer.cornerRadius = 70
        userImage.clipsToBounds =  true
        userImage.contentMode = .scaleAspectFit
        userImage.translatesAutoresizingMaskIntoConstraints = false
        return userImage
    }()
    
    
    private func setupUI() {

        addSubview(nameLabel)
        addSubview(productImage)
        addSubview(collectionLabel)
        addSubview(pickerView)
        addSubview(inventoryLabel)
        //This is where we set the constraints
        NSLayoutConstraint.activate([
            
            productImage.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            productImage.centerYAnchor.constraint(equalTo: topAnchor, constant: UIScreen.main.bounds.height * 0.05),
            productImage.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.13),
            productImage.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.13),
            
            
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: productImage.bottomAnchor, constant: UIScreen.main.bounds.height * 0.03),
            nameLabel.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.05),
            nameLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.7),
            
            
            collectionLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            collectionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: UIScreen.main.bounds.height * -0.025),
            collectionLabel.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.05),
            collectionLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width  * 0.7),
            
            inventoryLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            inventoryLabel.topAnchor.constraint(equalTo: collectionLabel.bottomAnchor, constant: UIScreen.main.bounds.height * 0),
            inventoryLabel.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.03),
            inventoryLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width  * 0.7),
            
            pickerView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            pickerView.topAnchor.constraint(equalTo: inventoryLabel.bottomAnchor, constant: UIScreen.main.bounds.height * 0),
            pickerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: UIScreen.main.bounds.height * -0.02),
//            pickerView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.1),
            pickerView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width  * 0.7)

            
            ])
    }
    
    //This will set the number for picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataSource.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if row < dataSource.count {
            
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
