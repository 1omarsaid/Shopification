//
//  JSONResponse.swift
//  OmarJSON
//
//  Created by Serxhio Gugo on 1/9/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import Foundation

struct JSONResponse: Codable {
    let customCollections: [CustomCollection]?
    
    enum CodingKeys: String, CodingKey {
        case customCollections = "custom_collections"
    }
}

struct CustomCollection: Codable {
    let id: Int?
    let handle, title: String?
    let updatedAt: String?
    let bodyHTML: String?
    let publishedAt: String?
    let sortOrder: SortOrder?
    let templateSuffix: String?
    let publishedScope: PublishedScope?
    let adminGraphqlAPIID: String?
    let image: Image?
    
    enum CodingKeys: String, CodingKey {
        case id, handle, title
        case updatedAt = "updated_at"
        case bodyHTML = "body_html"
        case publishedAt = "published_at"
        case sortOrder = "sort_order"
        case templateSuffix = "template_suffix"
        case publishedScope = "published_scope"
        case adminGraphqlAPIID = "admin_graphql_api_id"
        case image
    }
}

struct Image: Codable {
    let createdAt: String?
    let alt: JSONNull?
    let width, height: Int?
    let src: String?
    
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case  alt,width, height, src
    }
}

enum PublishedScope: String, Codable {
    case web = "web"
}

enum SortOrder: String, Codable {
    case bestSelling = "best-selling"
}

// MARK: Encode/decode helpers
//
class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
