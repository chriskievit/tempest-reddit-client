//
//  RedditDataResponse.swift
//  macreddit
//
//  Created by Chris on 15/08/2019.
//  Copyright © 2019 Tempest. All rights reserved.
//

import Foundation

class RedditDataResponse<T: RedditEntity>: Codable {
    var modHash: String?
    var after: String?
    var before: String?
    var limit: Int?
    var count: Int?
    var dist: Int?
    var children: [RedditEntityResponse<T>]
    
    enum CodingKeys: String, CodingKey {
        case modHash = "mod_hash"
        case after = "after"
        case before = "before"
        case limit = "limit"
        case count = "count"
        case dist = "dist"
        case children = "children"
    }
}
