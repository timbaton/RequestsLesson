//
//  ApiService.swift
//  SwiftRequests
//
//  Created by Тимур Бадретдинов on 15/12/2018.
//  Copyright © 2018 Ильдар Залялов. All rights reserved.
//

import Foundation

//https://api.vk.com/method/newsfeed.get?token_access=e0f7032733ce3c3ef4de19173bf3d7a85ce00b44c32c92c3bcc8a658062ac677181c11e8c2e75b60d2e6f&v=5.92

class ApiService {
    static let sharedInstance = ApiService()
    
    var login_url = URL(string: "https://oauth.vk.com/authorize?client_id=6770852&display=page&scope=wall,friends,docs&response_type=token&v=5.52")
    
    private var baseURL = "https://api.vk.com/method/"
    private var apiVersion = "5.92"
    private var accessToken: String? = nil
    
    private var profileMethod = "account.getProfileInfo"
    private var postsMethod = "newsfeed.get"
    private var postsCount = "10"
    private var postsFilter = "post"
    
    private var keyFilters = "filters"
    private var keyAccessToken = "access_token"
    private var keyVersion = "v"
    private var keyCount = "count"
    
    public func getProfileURL() -> URL{
        return getURL(method: profileMethod, count: nil, philter: nil)
    }
    
    public func getPostsURL() -> URL{
        return getURL(method: postsMethod, count: postsCount, philter: postsFilter)
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
    //    METHOD_NAME&access_token=ACCESS_TOKEN
}
