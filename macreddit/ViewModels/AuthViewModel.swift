//
//  AuthViewModel.swift
//  macreddit
//
//  Created by Chris on 02/08/2019.
//  Copyright © 2019 Tempest. All rights reserved.
//

import Foundation

class AuthViewModel {
    private let _callbackUrl = "brc://validate"
    private let _scopes = ["read", "mysubreddits", "account"]
    
    private func getClientId() -> String {
        let clientId: String = Bundle.main.infoDictionary?["ClientId"] as! String
        return clientId.replacingOccurrences(of: "\"", with: "")
    }
    
    func authUrl() -> URL? {
        return AuthController.generateAuthUrl(clientId: getClientId(), redirectUrl: _callbackUrl, scopes: _scopes)
    }
    
    func validateToken(code: String) {
        AuthController().getOAuthToken(clientId: getClientId(), redirectUrl: _callbackUrl, code: code, isRefreshToken: false) { (result: Result<AccessToken, RequestError>) in
            switch result {
                case .success(let token):
                    print(token.accessToken)
                    break
                case .failure(let error):
                    print(error)
                    break
            }
        }
    }
}
