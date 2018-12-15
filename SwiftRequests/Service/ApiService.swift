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
    
    var login_url = URL(string: "https://oauth.vk.com/authorize?client_id=6770852&display=page&redirect_uri=https://oauth.vk.com/blank.html&scope=friends&response_type=token&v=5.52")
    
    private var baseURL = "https://api.vk.com/method/"
    private var apiVersion = "5.92"
    private var accessToken = AuthService.sharedInstance.getUserToken()
    
    private var profileMethod = "/account.getProfileInfo"
    
    public func getProfileURL() -> URL{
        return getURL(method: profileMethod)
    }
    
    private func getURL(method: String) -> URL{
        let queryItems = [NSURLQueryItem(name: "access_token", value: accessToken), NSURLQueryItem(name: "v", value: apiVersion)]
        let urlComps = NSURLComponents(string: baseURL + method)!
        urlComps.queryItems = queryItems as [URLQueryItem]
        let URL = urlComps.url!
        return URL
    }
    //api.vk.com/method/METHOD_NAME?PARAMETERS&access_token=ACCESS_TOKEN&v=V
    //    METHOD_NAME&access_token=ACCESS_TOKEN
}
