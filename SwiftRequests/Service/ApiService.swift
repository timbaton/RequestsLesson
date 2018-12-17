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
    private var accessToken: String? = nil
    
    //keys for methods
    private var profileMethod = "account.getProfileInfo"
    private var postsMethod = "newsfeed.get"
    
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
        let url =  getURL(method: profileMethod, count: nil, philter: nil)
        return URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 10)
    }
    
    public func getPostsURL() -> URLRequest{
        let url = getURL(method: postsMethod, count: postsCount, philter: postsFilter)
        return URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 10)
    }
    
    private func getURL(method: String, count: String?, philter: String?) -> URL{
        accessToken = AuthService.sharedInstance.getUserToken()
        var queryItems: [URLQueryItem]?
        
        if count != nil{
            queryItems = [NSURLQueryItem(name: keyFilters, value: philter), NSURLQueryItem(name: keyCount, value: count), NSURLQueryItem(name: keyAccessToken, value: accessToken), NSURLQueryItem(name: keyVersion, value: apiVersion)] as [URLQueryItem]
        } else{
            queryItems = [NSURLQueryItem(name: keyAccessToken, value: accessToken), NSURLQueryItem(name: keyVersion, value: apiVersion)] as [URLQueryItem]
        }
        
        let urlComps = NSURLComponents(string: baseURL + method)!
        urlComps.queryItems = queryItems
        let URL = urlComps.url!
        print("given url \(URL)")
        return URL
    }
    //api.vk.com/method/METHOD_NAME?PARAMETERS&access_token=ACCESS_TOKEN&v=V
}
