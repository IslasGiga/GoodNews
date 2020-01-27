//
//  ArticlesResult.swift
//  GoodNews
//
//  Created by Islas on 1/24/20.
//  Copyright © 2020 Catskillet. All rights reserved.
//

import Foundation
struct ArticlesResult : Codable {
    let status : String?
    let totalResults : Int?
    let articles : [Article]?
    
    enum CodingKeys: String, CodingKey {
        
        case status = "status"
        case totalResults = "totalResults"
        case articles = "articles"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        totalResults = try values.decodeIfPresent(Int.self, forKey: .totalResults)
        articles = try values.decodeIfPresent([Article].self, forKey: .articles)
    }
    
}
