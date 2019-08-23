//
//  SubredditViewModel.swift
//  tempestclient
//
//  Created by Chris on 16/08/2019.
//  Copyright © 2019 Tempest. All rights reserved.
//

import Foundation

class SubredditViewModel: ListingViewModel {
    private let subreddit: Subreddit
    
    var batchSize: Int {
        get {
            return subreddit.batchSize
        }
    }
    
    var isLoading: Bool {
        get {
            return subreddit.isLoading
        }
    }
    
    var numPosts: Int {
        get {
            guard let posts = subreddit.posts else {
                return 0
            }
            
            return posts.count
        }
    }
    
    init(withSubreddit subreddit: Subreddit) {
        self.subreddit = subreddit
    }
    
    func next(completion: @escaping (Result<Bool, LoadingError>) -> Void) {
        subreddit.loadPosts(completion: completion)
    }
    
    func getPostAtIndex(index: Int) -> Post? {
        guard let posts = subreddit.posts, posts.count > index else {
            return nil
        }
        
        return posts[index]
    }
}
