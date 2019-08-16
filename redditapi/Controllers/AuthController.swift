//
//  AuthController.swift
//  tempestclient
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
    
    static func getAnonymousOAuthToken(clientId: String, redirectUrl: String, deviceId: String, result: @escaping (Result<AccessToken, RequestError>) -> Void) {
        let data = [
            "grant_type": "https://oauth.reddit.com/grants/installed_client",
            "device_id": deviceId
        ]
        
        return performTokenRequest(clientId: clientId, data: data, result: result)
    }
    
    static func getOAuthToken(clientId: String, redirectUrl: String, code: String, isRefreshToken: Bool, result: @escaping (Result<AccessToken, RequestError>) -> Void) {
        let data = [
            "grant_type": (isRefreshToken ? "refresh_token" : "authorization_code"),
            (isRefreshToken ? "refresh_token" : "code"): code,
            "redirect_uri": redirectUrl
        ]
        
        return performTokenRequest(clientId: clientId, data: data, result: result)
    }
    
    static func revokeToken(clientId: String, token: String, tokenType: String, result: @escaping (Result<Bool, RequestError>) -> Void) {
        let url = "https://www.reddit.com/api/v1/revoke_token"
        
        let authData: Data = String(format: "%@:", clientId).data(using: .utf8)!
        let headers = ["Authorization": String(format: "Basic %@", authData.base64EncodedString())]
        
        let data = [
            "token": token,
            "token_type_hint": tokenType
        ]
        
        return performFormPostRequest(url: url, data: data, additionalHeaders: headers, result: result)
    }
    
    private static func performTokenRequest(clientId: String, data: [String: String], result: @escaping (Result<AccessToken, RequestError>) -> Void) {
        let url = "https://www.reddit.com/api/v1/access_token"
        
        let authData: Data = String(format: "%@:", clientId).data(using: .utf8)!
        let headers = ["Authorization": String(format: "Basic %@", authData.base64EncodedString())]
        
        return performFormPostRequest(url: url, data: data, additionalHeaders: headers, result: result)
    }
}
