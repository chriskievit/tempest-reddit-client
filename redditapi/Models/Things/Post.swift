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
    var comments: Int
    var thumbnail: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case author
        case authorFlair = "author_flair_text"
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
        case comments = "num_comments"
        case thumbnail
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decode(String.self, forKey: .title)
        author = try values.decode(String.self, forKey: .author)
        authorFlair = try values.decodeIfPresent(String.self, forKey: .authorFlair) ?? ""
        created = try values.decode(Date.self, forKey: .created)
        clicked = try values.decode(Bool.self, forKey: .clicked)
        stickied = try values.decode(Bool.self, forKey: .stickied)
        spoiler = try values.decode(Bool.self, forKey: .spoiler)
        isVideo = try values.decode(Bool.self, forKey: .isVideo)
        nsfw = try values.decode(Bool.self, forKey: .nsfw)
        flair = try values.decodeIfPresent(String.self, forKey: .flair) ?? ""
        upvotes = try values.decode(Int.self, forKey: .upvotes)
        downvotes = try values.decode(Int.self, forKey: .downvotes)
        score = try values.decode(Int.self, forKey: .comments)
        comments = try values.decode(Int.self, forKey: .comments)
        thumbnail = try values.decode(String.self, forKey: .thumbnail)
        
        try super.init(from: decoder)
    }
}
