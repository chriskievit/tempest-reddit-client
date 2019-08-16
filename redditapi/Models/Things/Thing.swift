//
//  RedditEntity.swift
//  tempestclient
//
//  Created by Chris on 15/08/2019.
//  Copyright © 2019 Tempest. All rights reserved.
//

import Foundation

class Thing: Decodable {
    var name: String = ""
    var id: String = ""
    
    init(withName name: String, withId id: String) {
        self.name = name
        self.id = id
    }
}
