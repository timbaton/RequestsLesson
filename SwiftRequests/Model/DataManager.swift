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
    let keyId = "id"
    let keyProfile = "key_profile"
    
    func saveUserToken(with token: String) {
        UserDefaults.standard.setValue(token, forKey: keyToken)
        UserDefaults.standard.synchronize()
        print("saved token = \(token)")
    }
    
    func saveUserId(with id: String) {
        UserDefaults.standard.setValue(id, forKey: keyId)
        UserDefaults.standard.synchronize()
        print("saved token = \(id)")
    }
    
    func getUserid() -> String? {
        if let id = UserDefaults.standard.string(forKey: keyId){
            print("returned token \(id)")
            return id
        }
        print("returned id nil")
        return nil
    }
    
    func getUserToken() -> String? {
        if let token = UserDefaults.standard.string(forKey: keyToken){
            print("returned token \(token)")
            return token
        }
        print("returned token nil")
        return nil
    }
    
    func saveUserProfile(data: Data) {
        UserDefaults.standard.set(data, forKey: keyProfile)
    }
    
    func getUserProfile() -> ProfileModel {
        var data = UserDefaults.standard.data(forKey: keyProfile)
        
        var profile: ProfileModel? = nil
        let decoder = JSONDecoder()
        if let loadedPerson = try! decoder.decode(ProfileModel?.self, from: data!) {
            print(loadedPerson.response.first_name)
            profile = loadedPerson
            print("profile = \(profile)")
        }
        return profile!
    }
}
