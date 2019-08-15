//
//  RedditListing.swift
//  macreddit
//
//  Created by Chris on 15/08/2019.
//  Copyright © 2019 Tempest. All rights reserved.
//

import Foundation

class RedditListing<T: RedditEntity>: Codable {
    var kind: String!
    var data: RedditDataResponse<T>!
    
    enum CodingKeys: String, CodingKey {
        case kind = "kind"
        case data = "data"
    }
}
