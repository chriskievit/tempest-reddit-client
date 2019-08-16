//
//  Listing.swift
//  tempestclient
//
//  Created by Chris on 15/08/2019.
//  Copyright © 2019 Tempest. All rights reserved.
//

import Foundation

class Listing<T: Thing>: Decodable {
    var kind: String
    var modHash: String
    var after: String
    var before: String?
    var limit: Int?
    var dist: Int
    var children: [T]?
    
    enum CodingKeys: String, CodingKey {
        case kind
        case data
    }
    
    enum DataKeys: String, CodingKey {
        case modHash = "modhash"
        case after
        case before
        case children
        case limit
        case dist
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        kind = try values.decode(String.self, forKey: .kind)
        
        let dataValues = try values.nestedContainer(keyedBy: DataKeys.self, forKey: .data)
        
        modHash = try dataValues.decode(String.self, forKey: .modHash)
        after = try dataValues.decode(String.self, forKey: .after)
        before = try dataValues.decodeIfPresent(String.self, forKey: .before) ?? nil
        limit = try dataValues.decodeIfPresent(Int.self, forKey: .limit) ?? nil
        dist = try dataValues.decode(Int.self, forKey: .dist)
        children = try dataValues.decode([T].self, forKey: .children)
    }
}
