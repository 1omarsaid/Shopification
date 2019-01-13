//
//  CustomCollectionViewCell.swift
//  OmarJSON
//
//  Created by Serxhio Gugo on 1/10/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import UIKit
import Foundation

class CustomCollectionViewCell : UICollectionViewCell {
    
    //think of this as your viewDidLoad ...
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupUI()
    }
    
    let nameLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 20)
//        label.backgroundColor = .lightGray
        label.textAlignment = .center
        return label
    }()
    
//    let productImage : UIImageView = {
//        var userImage = UIImageView()
//        userImage.layer.masksToBounds = true
//        userImage.backgroundColor = .clear
//        userImage.layer.cornerRadius = 70
//        userImage.clipsToBounds =  true
//        userImage.contentMode = .scaleAspectFit
//        userImage.translatesAutoresizingMaskIntoConstraints = false
//        return userImage
//    }()

    
    private func setupUI() {
        addSubview(nameLabel)
//        addSubview(productImage)
        
    NSLayoutConstraint.activate([
        
//        productImage.centerXAnchor.constraint(equalTo: centerXAnchor),
//        productImage.topAnchor.constraint(equalTo: topAnchor),
//        productImage.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.1),
//        productImage.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.1),
        
        nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: UIScreen.main.bounds.height * 0),
        nameLabel.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.05),
        nameLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.7),
        
        
        
        
        ])
    }
    
    
    
    //This is required but nobody ever uses it,
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
