//
//  ExtraDetailViewController.swift
//  OmarJSON
//
//  Created by omar on 2019-01-14.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import UIKit

class ExtraDetailViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    

    let screenSize: CGRect = UIScreen.main.bounds
    let window = UIApplication.shared.keyWindow
    
    var dataSource = [Variant]()
    
    var roundedView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height * 0.15, width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.8))
        view.backgroundColor = .white
        view.layer.cornerRadius = 40
        return view
    }()
    
    
    var productImage: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        iv.layer.cornerRadius = 10
        iv.contentMode = .scaleToFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    
    
    var nameLabel: UILabel = {
        let lbl = UILabel(frame: CGRect(x: UIScreen.main.bounds.width * 0.42 , y: UIScreen.main.bounds.size.height * 0.045, width: UIScreen.main.bounds.size.width * 0.45 , height: UIScreen.main.bounds.size.height * 0.03))
        lbl.numberOfLines = 0
        lbl.textColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        lbl.font = UIFont.boldSystemFont(ofSize: 12)
        return lbl
    }()
    
    var idLabel: UILabel = {
        let lbl = UILabel(frame: CGRect(x: UIScreen.main.bounds.width * 0.42 , y: UIScreen.main.bounds.size.height * 0.07, width: UIScreen.main.bounds.size.width * 0.45 , height: UIScreen.main.bounds.size.height * 0.03))
        lbl.numberOfLines = 0
        lbl.textColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        lbl.font = UIFont.boldSystemFont(ofSize: 12)
        return lbl
    }()

    
    var tagsLabel: UILabel = {
        let lbl = UILabel(frame: CGRect(x: UIScreen.main.bounds.width * 0.42 , y: UIScreen.main.bounds.size.height * 0.095, width: UIScreen.main.bounds.size.width * 0.45 , height: UIScreen.main.bounds.size.height * 0.05))
        lbl.numberOfLines = 0
        lbl.textColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        lbl.font = UIFont.boldSystemFont(ofSize: 12)
        return lbl
    }()
    
    var productTypeLabel: UILabel = {
        let lbl = UILabel(frame: CGRect(x: UIScreen.main.bounds.width * 0.42 , y: UIScreen.main.bounds.size.height * 0.14, width: UIScreen.main.bounds.size.width * 0.45 , height: UIScreen.main.bounds.size.height * 0.03))
        lbl.numberOfLines = 0
        lbl.textColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        lbl.font = UIFont.boldSystemFont(ofSize: 12)
        return lbl
    }()
    
    
    var vendorLabel: UILabel = {
        let lbl = UILabel(frame: CGRect(x: UIScreen.main.bounds.width * 0.42 , y: UIScreen.main.bounds.size.height * 0.16, width: UIScreen.main.bounds.size.width * 0.45 , height: UIScreen.main.bounds.size.height * 0.06))
        lbl.numberOfLines = 0
        lbl.textColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        lbl.font = UIFont.boldSystemFont(ofSize: 12)
        return lbl
    }()
    
    var publishLabel: UILabel = {
        let lbl = UILabel(frame: CGRect(x: UIScreen.main.bounds.width / 2 - (UIScreen.main.bounds.size.width * 0.7 / 2), y: UIScreen.main.bounds.size.height * 0.7, width: UIScreen.main.bounds.size.width * 0.7 , height: UIScreen.main.bounds.size.height * 0.03))
        lbl.numberOfLines = 0
        lbl.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        lbl.textAlignment = .center
        lbl.font = UIFont.boldSystemFont(ofSize: 11)
        return lbl
    }()
    
    
    var updateLabel: UILabel = {
        let lbl = UILabel(frame: CGRect(x: UIScreen.main.bounds.width / 2 - (UIScreen.main.bounds.size.width * 0.7 / 2), y: UIScreen.main.bounds.size.height * 0.715, width: UIScreen.main.bounds.size.width * 0.7 , height: UIScreen.main.bounds.size.height * 0.03))
        lbl.numberOfLines = 0
        lbl.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        lbl.textAlignment = .center
        lbl.font = UIFont.boldSystemFont(ofSize: 11)
        return lbl
    }()
    
    var inventoryLabel: UILabel = {
        let lbl = UILabel(frame: CGRect(x: UIScreen.main.bounds.width * 0.07, y: UIScreen.main.bounds.size.height * 0.25, width: UIScreen.main.bounds.size.width * 0.9 , height: UIScreen.main.bounds.size.height * 0.03))
        lbl.text = "Inventory(Color: Quanitity)"
        lbl.numberOfLines = 0
        lbl.textColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        lbl.font = UIFont.boldSystemFont(ofSize: 22)
        return lbl
    }()
    
    var htmlLabel: UILabel = {
        let lbl = UILabel(frame: CGRect(x: UIScreen.main.bounds.width * 0.07, y: UIScreen.main.bounds.size.height * 0.28, width: UIScreen.main.bounds.size.width * 0.8 , height: UIScreen.main.bounds.size.height * 0.4))
        lbl.numberOfLines = 0
        lbl.textColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        lbl.font = UIFont.boldSystemFont(ofSize: 15)
        return lbl
    }()
    
    lazy var pickerView: UIPickerView={
        let pv = UIPickerView()
        pv.translatesAutoresizingMaskIntoConstraints = false
        pv.delegate = self
        pv.dataSource = self
        pv.showsSelectionIndicator = true

        pv.layer.cornerRadius = 5
        return pv
    }()
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        view.addSubview(roundedView)
        roundedView.center.x = view.center.x
        roundedView.addSubview(productImage)
        roundedView.addSubview(nameLabel)
        roundedView.addSubview(idLabel)
        roundedView.addSubview(tagsLabel)
        roundedView.addSubview(productTypeLabel)
        roundedView.addSubview(publishLabel)
        roundedView.addSubview(updateLabel)
        roundedView.addSubview(pickerView)
        roundedView.addSubview(vendorLabel)
        roundedView.addSubview(inventoryLabel)
        roundedView.addSubview(htmlLabel)
        setupUI()

    }
    
    
    func setupUI() {

        productImage.leftAnchor.constraint(equalTo: roundedView.leftAnchor, constant: roundedView.bounds.width * 0.05).isActive = true
        productImage.topAnchor.constraint(equalTo: roundedView.topAnchor, constant: roundedView.bounds.height * 0.05).isActive = true
        productImage.heightAnchor.constraint(equalToConstant: roundedView.bounds.width * 0.4).isActive = true
        productImage.widthAnchor.constraint(equalToConstant: roundedView.bounds.width * 0.4).isActive = true
        
        
        //Picker view constraints
        pickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        pickerView.topAnchor.constraint(equalTo: inventoryLabel.bottomAnchor).isActive = true
//        pickerView.bottomAnchor.constraint(equalTo:, constant: UIScreen.main.bounds.height * -0.02),
        pickerView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width  * 0.7).isActive = true
        pickerView.bottomAnchor.constraint(equalTo: publishLabel.topAnchor, constant: -UIScreen.main.bounds.height * 0.27).isActive = true
        
        }
 
    
    //MARK: PickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
//        //Checking to make sure we dont fall out of the index
//        if row < dataSource.count {
//            //Returning the variant's title and the inventory numebers as the title in the row
            return "\(dataSource[row].title): \(dataSource[row].inventoryQuantity)"
//        } else {
//            return nil
//        }
    }
    
    
}
