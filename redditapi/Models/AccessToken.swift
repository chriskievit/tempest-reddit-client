//
//  AccessToken.swift
//  tempestclient
//
//  Created by Chris on 02/08/2019.
//  Copyright © 2019 Tempest. All rights reserved.
//

import Foundation

class AccessToken: Decodable {
    var accessToken: String
    var tokenType: String
    var expiresIn: Int
    var expiresAt: Date?
    var scope: String
    var refreshToken: String?
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case scope = "scope"
        case refreshToken = "refresh_token"
    }
    
    func isValid() -> Bool {
        return expiresAt != nil && Date() < expiresAt!
    }
    
    func setExpiry() {
        expiresAt = Calendar.current.date(byAdding: .second, value: expiresIn, to: Date())!
    }
}
