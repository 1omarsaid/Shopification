//
//  JSONResponse3.swift
//  OmarJSON
//
//  Created by omar on 2019-01-10.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import Foundation

struct Products: Codable {
    let products: [Product]
}

struct Product: Codable {
//    let id: Int
    let title: String
    let variants: [Variant]
    

    enum CodingKeys: String, CodingKey {
        case title
        case variants

    }
}

struct Variant: Codable {
    let inventoryQuantity: Int
    let title: String

    
    enum CodingKeys: String, CodingKey {
        case inventoryQuantity = "inventory_quantity"
        case title

    }
}
