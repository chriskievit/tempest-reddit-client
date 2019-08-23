//
//  Subreddit.swift
//  tempestclient
//
//  Created by Chris on 16/08/2019.
//  Copyright © 2019 Tempest. All rights reserved.
//

import Foundation

class Subreddit: Thing {
    private var after: String?
    private var before: String?
    private var hasAdditionalPosts: Bool = true
    
    let batchSize: Int = 25
    
    var posts: [Post]?
    var isLoading: Bool  = false
    
    func loadPosts(completion: @escaping (Result<Bool, LoadingError>) -> Void) {
        if hasAdditionalPosts {
            isLoading = true
            SubredditController.getPosts(subreddit: name, before: nil, after: after, count: posts?.count) { (result: Result<Listing<Post>, RequestError>) in
                switch result {
                case .success(let listing):
                    self.addPosts(fromListing: listing)
                    self.isLoading = false
                    completion(.success(true))
                    break
                case .failure(_):
                    self.isLoading = false
                    completion(.failure(.generalError))
                    break
                }
            }
        } else {
            completion(.success(true))
        }
    }
    
    private func addPosts(fromListing listing: Listing<Post>) {
        if posts == nil {
            posts = [Post]()
        }
        
        if let newPosts = listing.children {
            if newPosts.count < batchSize {
                hasAdditionalPosts = false
            }
            
            posts!.append(contentsOf: newPosts)
            after = listing.after
            before = listing.before
        }
    }
}
