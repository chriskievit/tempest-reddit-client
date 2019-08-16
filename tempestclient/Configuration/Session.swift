//
//  Session.swift
//  tempestclient
//
//  Created by Chris on 15/08/2019.
//  Copyright © 2019 Tempest. All rights reserved.
//

import Foundation

class Session {
    private let _callbackUrl = "brc://validate"
    private let _scopes = ["read", "mysubreddits", "account"]
    
    private func getClientId() -> String {
        let clientId: String = Bundle.main.infoDictionary?["ClientId"] as! String
        return clientId.replacingOccurrences(of: "\"", with: "")
    }
    
    private var _authToken: AccessToken?
    
    func isAuthenticated() -> Bool {
        return _authToken != nil && _authToken!.isValid()
    }
    
    func authenticate(code: String?, completion: @escaping (Result<Bool, RequestError>) -> Void) {
        if let code = code {
            AuthController.getOAuthToken(clientId: getClientId(), redirectUrl: _callbackUrl, code: code, isRefreshToken: false, result: { (result: Result<AccessToken, RequestError>) in
                self.validateAuthTokenResult(result: result, completion: completion)
            })
        } else {
            AuthController.getAnonymousOAuthToken(clientId: getClientId(), redirectUrl: _callbackUrl, deviceId: ApplicationContext.shared.deviceId, result: { (result: Result<AccessToken, RequestError>) in
                self.validateAuthTokenResult(result: result, completion: completion)
            })
        }
    }
    
    func setAuthToken(token: AccessToken) {
        token.setExpiry()
        _authToken = token
    }
    
    func getAuthUrl() -> URL? {
        return AuthController.generateAuthUrl(clientId: getClientId(), redirectUrl: _callbackUrl, scopes: _scopes)
    }
    
    func logout(completion: @escaping (Result<Bool, RequestError>) -> Void) {
        if let token = _authToken {
            AuthController.revokeToken(clientId: getClientId(), token: token.accessToken, tokenType: token.tokenType, result: completion)
        } else {
            completion(.success(true))
        }
    }
    
    private func validateAuthTokenResult(result: Result<AccessToken, RequestError>, completion: @escaping (Result<Bool, RequestError>) -> Void) {
        switch result {
        case .success(let token):
            self.setAuthToken(token: token)
            completion(.success(true))
            break;
        case .failure(let error):
            completion(.failure(error))
            break;
        }
    }
}
