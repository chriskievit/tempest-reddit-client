//
//  SubredditController.swift
//  tempestclient
//
//  Created by Chris on 17/08/2019.
//  Copyright © 2019 Tempest. All rights reserved.
//

import Foundation

class SubredditController: ListingController {
    static func getPosts(subreddit: String, before: String?, after: String?, count: Int?, completion: @escaping (Result<Listing<Post>, RequestError>) -> Void) {
        return getListing(url: "https://oauth.reddit.com/r/\(subreddit).json", before: before, after: after, count: count, completion: completion)
    }
}
