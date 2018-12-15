
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
    
    public func saveToken(token: String){
        dataManager.saveUserToken(with: token)
    }
    
    public func getUserToken() -> String? {
        if let token = dataManager.getUserToken(){
            return token
        }
        return nil
    }
}
