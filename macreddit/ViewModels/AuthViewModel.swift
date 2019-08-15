//
//  AuthViewModel.swift
//  macreddit
//
//  Created by Chris on 02/08/2019.
//  Copyright © 2019 Tempest. All rights reserved.
//

import Foundation

class AuthViewModel {    
    func authUrl() -> URL? {
        return ApplicationContext.shared.session.getAuthUrl()
    }
    
    func authenticate(code: String, completion: @escaping (Result<Bool, RequestError>) -> Void) -> Void {
        return ApplicationContext.shared.session.authenticate(code: code, completion: completion)
    }
}
