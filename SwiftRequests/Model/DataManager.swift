//
//  DataManager.swift
//  SwiftRequests
//
//  Created by Тимур Бадретдинов on 14/12/2018.
//  Copyright © 2018 Ильдар Залялов. All rights reserved.
//

import Foundation

class DataManager: DataManagerProtocol {
    
    static let sharedInstance = DataManager()
    let keyToken = "token"
    
    func saveUserToken(with token: String) {
        UserDefaults.standard.setValue(token, forKey: keyToken)
        UserDefaults.standard.synchronize()
        print("saved token = \(token)")
    }
    
    func getUserToken() -> String? {
        if let token = UserDefaults.standard.string(forKey: keyToken){
            print("returned token \(token)")
            return token
        }
        print("returned token nil")
        return nil
    }
    
    func saveUserProfile(data: Data, key: String) {
        UserDefaults.standard.set(data, forKey: key)
    }
}
