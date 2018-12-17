//
//  RequestManager.swift
//  SwiftRequests
//
//  Created by Тимур Бадретдинов on 16/12/2018.
//  Copyright © 2018 Ильдар Залялов. All rights reserved.
//

import Foundation
import UIKit

class RequestManager: RequestManagerProtocol {
    
    public static var sharedInstance = RequestManager()
    
    func downloadPosts(completionHandler: @escaping (Bool) -> Void) {
        let profileURL = ApiService.sharedInstance.getPostsURL()
        
        let task = URLSession.shared.dataTask(with: profileURL) { data, response, error in
            print("\(String(describing: response))")
            if let error = error{
                print("\(error)")
            }
            if let data = data {
                DataManager.sharedInstance.savePosts(data: data)
                if let loadedPosts = String.init(data: data, encoding: String.Encoding.utf8) {
                    print("\nзагрузили посты: \(loadedPosts)")
                }
            }
            completionHandler(true)
        }
        task.resume()
    }
    
    func downloadUserProfile(completionHandler: @escaping (Bool) -> Void) {
        let profileURL = ApiService.sharedInstance.getProfileURL()
        
        let task = URLSession.shared.dataTask(with: profileURL) { (data, response, error) in
            print("\(String(describing: response))")
            if error != nil{
                completionHandler(false)
            }
            if let data = data {
                DataManager.sharedInstance.saveUserProfile(data: data)
                if let loadedPerson = String.init(data: data, encoding: String.Encoding.utf8) {
                    print("\nзагрузили пользователя: \(loadedPerson)")
                }
            }
            completionHandler(true)
        }
        task.resume()
    }
    
    func likePost(itemId: String, sourceId: String) {
        let likeURL = ApiService.sharedInstance.getLikeURL(itemId: itemId, sourceId: sourceId)
        let task = URLSession.shared.dataTask(with: likeURL) { (data, response, error) in
            print("\(String(describing: response))")
            if let data = data {
                if let likedCount = String.init(data: data, encoding: String.Encoding.utf8) {
                    print("\nОтправили лайк: \(likedCount)")
                }
            }
        }
        task.resume()
    }
    
    func dislikePost(itemId: String, sourceId: String) {
        let likeURL = ApiService.sharedInstance.getDeleteLikeURL(itemId: itemId, sourceId: sourceId)
        let task = URLSession.shared.dataTask(with: likeURL) { (data, response, error) in
            print("\(String(describing: response))")
            if let data = data {
                if let likedCount = String.init(data: data, encoding: String.Encoding.utf8) {
                    print("\nУбрали лайк: \(likedCount)")
                }
            }
        }
        task.resume()
    }
}
