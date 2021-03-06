//
//  RequestManagerProtocol.swift
//  SwiftRequests
//
//  Created by Тимур Бадретдинов on 17/12/2018.
//  Copyright © 2018 Ильдар Залялов. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ success: Bool) -> Void

protocol RequestManagerProtocol {    
    func downloadUserProfile(completionHandler: @escaping (Bool) -> Void)
    
    func downloadPosts(completionHandler: @escaping (Bool) -> Void)
    
    func likePost(itemId: String, sourceId: String)
    
    func dislikePost(itemId: String, sourceId: String)
    
    func postNewPost(message: String, completionHandler: @escaping (Bool) -> Void)
}
