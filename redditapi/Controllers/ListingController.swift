//
//  ListingController.swift
//  tempestclient
//
//  Created by Chris on 15/08/2019.
//  Copyright © 2019 Tempest. All rights reserved.
//

import Foundation

protocol ListingController : ApiController { }

extension ListingController {
    static func getListing<T: Listing<Tthing>, Tthing: Thing>(url: String, before: String?, after: String?, count: Int?, completion: @escaping (Result<T, RequestError>) -> Void) {
        if let before = before, !before.isEmpty,
            let after = after, !after.isEmpty {
            completion(.failure(.parameterEncodingError))
            return
        }
        
        var fullUrl = url
        if let before = before, !before.isEmpty {
            fullUrl = "\(url)?before=\(before)&raw_json=1"
        } else if let after = after, !after.isEmpty, let count = count {
            fullUrl = "\(url)?after=\(after)&count=\(count)&raw_json=1"
        } else {
            fullUrl = "\(url)?raw_json=1"
        }
        
        return performGetRequest(url: fullUrl, result: completion)
    }
}
