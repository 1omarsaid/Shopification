//
//  JSONResponse.swift
//  OmarJSON
//
//  Created by Serxhio Gugo on 1/9/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import Foundation
//This is the struct for the first JSON Responce
struct JSONResponse: Codable {
    //Creating a variable that belongs to the CustomCollection to do the hierarchy of the JSON structure
    let customCollections: [CustomCollection]?
    //Since the name of the custom collections in the JSON responce does not conform to the camel case, I used
    //an enum to restate it
    enum CodingKeys: String, CodingKey {
        case customCollections = "custom_collections"
    }
}

//For the custom collections, I created a struc of the values that we need.
struct CustomCollection: Codable {
    let id: Int?
    let title: String?
    let bodyHTML: String?
    //Creating an image that is a variable of the image struct due to the hierarchy of the JSON Structure
    let image: Image?
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case bodyHTML = "body_html"
        case image
    }
}

//This struct is for the Image in the JSON structure.
struct Image: Codable {
    let src: String?
    
    enum CodingKeys: String, CodingKey {
        case src
    }
}

