//
//  JSONResponse2.swift
//  OmarJSON
//
//  Created by omar on 2019-01-10.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import Foundation

struct Collects: Codable {
    let collects: [Collect]
}

struct Collect: Codable {
    let productID: Int
    
    enum CodingKeys: String, CodingKey {
        case productID = "product_id"
    }
}
