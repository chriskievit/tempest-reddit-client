//
//  RedditEntity.swift
//  tempestclient
//
//  Created by Chris on 15/08/2019.
//  Copyright © 2019 Tempest. All rights reserved.
//

import Foundation

class Thing: Decodable {
    var name: String
    var id: String
    
    private enum CodingKeys: String, CodingKey {
        case name
        case id
    }
    
    private enum DataKeys: String, CodingKey {
        case data
    }
    
    init(withName name: String, withId id: String) {
        self.name = name
        self.id = id
    }
    
    required init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        
        if let values = values {
            name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
            id = try values.decodeIfPresent(String.self, forKey: .id) ?? ""
        } else {
            name = ""
            id = ""
        }
    }
}
