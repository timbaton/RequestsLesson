
//
//  AuthRepository.swift
//  SwiftRequests
//
//  Created by Тимур Бадретдинов on 14/12/2018.
//  Copyright © 2018 Ильдар Залялов. All rights reserved.
//

import Foundation
import UIKit

class AuthService {
    
    static let sharedInstance = AuthService()
    private let dataManager = DataManager.sharedInstance
    
    public func saveUserSettings(token: String, id: String){
        dataManager.saveUserToken(with: token)
        dataManager.saveUserId(with: id)
    }
    
    public func getUserToken() -> String? {
        if let token = dataManager.getUserToken(){
            return token
        }
        return nil
    }
    
    public func getUserId() -> String?{
        if let id = dataManager.getUserid(){
            return id
        }
        return nil
    }
}
