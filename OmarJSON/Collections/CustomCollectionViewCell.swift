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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //Creating the background color of the cell to white
        backgroundColor = .white
        //Setting up the User Interface
        setupUI()
    }
    
    //Creating a name label that will be used to display the collections name
    let nameLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    private func setupUI() {
        //Adding the nameLabel to the cell's view
        addSubview(nameLabel)
        
        //Setting up the constraints for the nameLabel
    NSLayoutConstraint.activate([
        nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: UIScreen.main.bounds.height * 0),
        nameLabel.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.05),
        nameLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.7),
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
