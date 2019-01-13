//
//  JSONResponse2.swift
//  OmarJSON
//
//  Created by omar on 2019-01-10.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import Foundation

//Creating a struct for the Collects
struct Collects: Codable {
    //Created a variable to reference the Collect that is in the second order of the JSON Structure
    let collects: [Collect]
}

//Created a struct for the Collecte to reference the product ID
struct Collect: Codable {
    let productID: Int
    
    //Used an enum since the ProductID variable in the JSON format is not camel case
    enum CodingKeys: String, CodingKey {
        case productID = "product_id"
    }
}
