//
//  JSONResponse3.swift
//  OmarJSON
//
//  Created by omar on 2019-01-10.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import Foundation

//Creating a struct for the products
struct Products: Codable {
    //Created a variable to reference the products that is in the second order of the JSON Structure
    let products: [Product]
}

//Created a struct for the products to reference the product name and variants
struct Product: Codable {
    let title, bodyHTML, vendor, productType, tags: String
    let id: Int
    let variants: [Variant]
    let image: imagesrc
    let updatedAt, publishedAt: String
    
    enum CodingKeys: String, CodingKey {
        case title, vendor, tags
        case variants
        case image
        case id
        case updatedAt = "updated_at"
        case publishedAt = "published_at"
        case productType = "product_type"
        case bodyHTML = "body_html"
        
    }
}

struct imagesrc: Codable {
    let src: String?
    
    enum CodingKeys: String, CodingKey {
        case src
    }
}


//Creating a struct for the variants
struct Variant: Codable {
    let inventoryQuantity: Int
    let title: String
    
    //Created a variable to reference the variants that is in the third order of the JSON Structure
    enum CodingKeys: String, CodingKey {
        case inventoryQuantity = "inventory_quantity"
        case title

    }
}
