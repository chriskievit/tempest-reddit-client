//
//  AccessToken.swift
//  macreddit
//
//  Created by Chris on 02/08/2019.
//  Copyright © 2019 Tempest. All rights reserved.
//

import Foundation

class AccessToken: Codable {
    var accessToken: String
    var tokenType: String
    var expiresIn: String
    var expiresAt: Date
    var scope: String
    var refreshToken: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case expiresAt = "expires_at"
        case scope = "scope"
        case refreshToken = "refresh_token"
    }
}
