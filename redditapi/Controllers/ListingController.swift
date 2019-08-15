//
//  ListingController.swift
//  macreddit
//
//  Created by Chris on 15/08/2019.
//  Copyright © 2019 Tempest. All rights reserved.
//

import Foundation

protocol ListingController : ApiController { }

extension ListingController {
    static func getListing<T: RedditListing<RedditEntity>>(url: String, before: String?, after: String?, count: Int?, completion: @escaping (Result<T, RequestError>) -> Void) {
        if let before = before, !before.isEmpty,
            let after = after, !after.isEmpty {
            completion(.failure(.parameterEncodingError))
            return
        }
        
        var fullUrl = url
        if let before = before, !before.isEmpty {
            fullUrl = "\(url)?before=\(before)"
        } else if let after = after, !after.isEmpty, let count = count {
            fullUrl = "\(url)?after=\(after)&count=\(count)"
        }
        
        return performGetRequest(url: fullUrl, result: completion)
    }
}
