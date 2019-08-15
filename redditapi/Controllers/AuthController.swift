//
//  AuthController.swift
//  macreddit
//
//  Created by Chris on 02/08/2019.
//  Copyright © 2019 Tempest. All rights reserved.
//

import Foundation

class AuthController: ApiController {
    static func generateAuthUrl(clientId: String, redirectUrl: String, scopes: [String]) -> URL? {
        let state: String = UUID().uuidString
        let redirectUri = redirectUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let scope = scopes.joined(separator: "%20")
        
        let urlString: String = String(format:"https://www.reddit.com/api/v1/authorize.compact?client_id=%@&response_type=code&state=%@&redirect_uri=%@&duration=permanent&scope=%@", clientId, state, redirectUri, scope)
        
        return URL(string: urlString)
    }
    
    func getOAuthToken(clientId: String, redirectUrl: String, code: String, isRefreshToken: Bool, result: @escaping (Result<AccessToken, RequestError>) -> Void) {
        let url = "https://www.reddit.com/api/v1/access_token"
        
        let authData: Data = String(format: "%@:", clientId).data(using: .utf8)!
        let headers = ["Authorization": String(format: "Basic %@", authData.base64EncodedString())]
        
        let data = [
            "grant_type": (isRefreshToken ? "refresh_token" : "authorization_code"),
            (isRefreshToken ? "refresh_token" : "code"): code,
            "redirect_uri": redirectUrl
        ]
        
        return performFormPostRequest(url: url, data: data, additionalHeaders: headers, result: result)
    }
}
