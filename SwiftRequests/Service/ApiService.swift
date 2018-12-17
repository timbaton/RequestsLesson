//
//  ApiService.swift
//  SwiftRequests
//
//  Created by Тимур Бадретдинов on 15/12/2018.
//  Copyright © 2018 Ильдар Залялов. All rights reserved.
//

import Foundation

class ApiService {
    static let sharedInstance = ApiService()
    
    //URL for getting token
    var login_url = URL(string: "https://oauth.vk.com/authorize?client_id=6770852&display=page&scope=wall,friends,docs&response_type=token&v=5.52")
    
    //main constants
    private var baseURL = "https://api.vk.com/method/"
    private var apiVersion = "5.92"
    
    
    //keys for methods
    private var profileMethod = "account.getProfileInfo"
    private var postsMethod = "newsfeed.get"
    private var likeMethod = "likes.add"
    private var deleteLikeMethod = "likes.delete"
    
    //constants and keys for postMethod
    private var postsCount = "10"
    private var postsFilter = "post"
    private var keyFilters = "filters"
    
    //main keys
    private var keyAccessToken = "access_token"
    private var keyVersion = "v"
    private var keyCount = "count"
    
    /// Получить URLRequest для загрузги профиля пользователя
    ///
    /// - Returns: return 
    public func getProfileURL() -> URLRequest{
        var accessToken = AuthService.sharedInstance.getUserToken()
        let queryItems = [NSURLQueryItem(name: keyAccessToken, value: accessToken), NSURLQueryItem(name: keyVersion, value: apiVersion)] as [URLQueryItem]
        
        return buildURLRequest(method: profileMethod, queryItems: queryItems)
    }
    
    public func getPostsURL() -> URLRequest{
        var accessToken = AuthService.sharedInstance.getUserToken()
        let queryItems = [NSURLQueryItem(name: keyFilters, value: postsFilter), NSURLQueryItem(name: keyCount, value: postsCount), NSURLQueryItem(name: keyAccessToken, value: accessToken), NSURLQueryItem(name: keyVersion, value: apiVersion)] as [URLQueryItem]
        
        return buildURLRequest(method: postsMethod, queryItems: queryItems)
    }
    
    public func getLikeURL(itemId: String, sourceId: String) -> URLRequest{
        var accessToken = AuthService.sharedInstance.getUserToken()
        let queryItems = [NSURLQueryItem(name: keyAccessToken, value: accessToken), NSURLQueryItem(name: "type", value: "post"), NSURLQueryItem(name: "owner_id", value: sourceId), NSURLQueryItem(name: "item_id", value: itemId), NSURLQueryItem(name: keyVersion, value: apiVersion)] as [URLQueryItem]
        
        return buildURLRequest(method: likeMethod, queryItems: queryItems)
    }
    
    public func getDeleteLikeURL(itemId: String, sourceId: String) -> URLRequest{
        let accessToken = AuthService.sharedInstance.getUserToken()
        let queryItems = [NSURLQueryItem(name: keyAccessToken, value: accessToken), NSURLQueryItem(name: "type", value: "post"), NSURLQueryItem(name: "owner_id", value: sourceId), NSURLQueryItem(name: "item_id", value: itemId), NSURLQueryItem(name: keyVersion, value: apiVersion)] as [URLQueryItem]
        
        return buildURLRequest(method: deleteLikeMethod, queryItems: queryItems)
    }
    
    private func buildURLRequest(method: String, queryItems: [URLQueryItem]?) -> URLRequest{
        let urlComps = NSURLComponents(string: baseURL + method)!
        urlComps.queryItems = queryItems
        let url = urlComps.url!
        print("builded url for method \(method) : \(url)")
        return URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 10)
    }
    //api.vk.com/method/METHOD_NAME?PARAMETERS&access_token=ACCESS_TOKEN&v=V
}
