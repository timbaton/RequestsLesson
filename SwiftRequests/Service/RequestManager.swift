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
    
    func downloadFileFromURL(url: URLRequest, completionHandler: @escaping (Bool) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            print("\(String(describing: response))")
            if let error = error{
                completionHandler(false)
            }
            if let data = data {
                DataManager.sharedInstance.saveUserProfile(data: data)
                
                let decoder = JSONDecoder()
                if let loadedPerson = String.init(data: data, encoding: String.Encoding.utf8) {
                    print(loadedPerson)
                }
            }
            completionHandler(true)
        }
        task.resume()
    }
}
