//
//  PostModel.swift
//  SwiftRequests
//
//  Created by Тимур Бадретдинов on 16/12/2018.
//  Copyright © 2018 Ильдар Залялов. All rights reserved.
//

import Foundation

struct PostModel: Codable {
    var response: PostInfo
}

struct PostInfo: Codable {
    var items: [Post]
}

struct Post: Codable{
    var type: String
    var marked_as_ads: Int?
    var post_id: Int
    var source_id: Int
    var date: Int
    var text: String
    var attachments: [Attachment]?
    var comments: Comments?
    var likes: Likes?
}

struct Attachment: Codable {
    var type: String
    var photo: Photo?
}

struct Photo: Codable {
    var id: Int
    var link: URL?
    
    enum CodingKeys: String, CodingKey {
        case id
        case link = "photo_604"
    }
}

struct Comments: Codable {
    var count: Int
}

struct Likes: Codable {
    var count: Int
    var user_likes: Int
    var can_like: Int
}

struct LikePostResponse: Codable {
    var response: PostLikes
}

struct PostLikes: Codable{
    var likes: Int
}
