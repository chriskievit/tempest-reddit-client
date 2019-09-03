//
//  Post.swift
//  tempestclient
//
//  Created by Chris on 16/08/2019.
//  Copyright © 2019 Tempest. All rights reserved.
//

import Foundation

class Post: Thing {
    var title: String
    var author: String
    var authorFlair: String?
    var subreddit: String
    var created: Date
    var clicked: Bool
    var stickied: Bool
    var spoiler: Bool
    var isVideo: Bool
    var nsfw: Bool
    var flair: String?
    var upvotes: Int
    var downvotes: Int
    var score: Int
    var numComments: Int
    var thumbnail: String?
    
    private enum CodingKeys: String, CodingKey {
        case title
        case author
        case authorFlair = "author_flair_text"
        case subreddit
        case created
        case clicked
        case stickied
        case spoiler
        case isVideo = "is_video"
        case nsfw = "over_18"
        case flair = "link_flair_text"
        case upvotes = "ups"
        case downvotes = "downs"
        case score
        case numComments = "num_comments"
        case thumbnail
    }
    
    private enum DataKeys: String, CodingKey {
        case data
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: DataKeys.self)
        let dataValues = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        
        title = try dataValues.decode(String.self, forKey: .title)
        author = try dataValues.decode(String.self, forKey: .author)
        authorFlair = try dataValues.decodeIfPresent(String.self, forKey: .authorFlair)
        subreddit = try dataValues.decode(String.self, forKey: .subreddit)
        created = try dataValues.decode(Date.self, forKey: .created)
        clicked = try dataValues.decode(Bool.self, forKey: .clicked)
        stickied = try dataValues.decode(Bool.self, forKey: .stickied)
        spoiler = try dataValues.decode(Bool.self, forKey: .spoiler)
        isVideo = try dataValues.decode(Bool.self, forKey: .isVideo)
        nsfw = try dataValues.decode(Bool.self, forKey: .nsfw)
        flair = try dataValues.decodeIfPresent(String.self, forKey: .flair)
        upvotes = try dataValues.decode(Int.self, forKey: .upvotes)
        downvotes = try dataValues.decode(Int.self, forKey: .downvotes)
        score = try dataValues.decode(Int.self, forKey: .score)
        numComments = try dataValues.decode(Int.self, forKey: .numComments)
        thumbnail = try dataValues.decodeIfPresent(String.self, forKey: .thumbnail)
        
        let superDecoder = try values.superDecoder(forKey: .data)
        try super.init(from: superDecoder)
    }
}
