//
//  Profile.swift
//  SwiftRequests
//
//  Created by Тимур Бадретдинов on 15/12/2018.
//  Copyright © 2018 Ильдар Залялов. All rights reserved.
//

import Foundation

struct ProfileModel: Codable {
    var response: ProfileInfo
}

struct ProfileInfo: Codable{
    var first_name: String
    var last_name: String
    var bdate: String
    var home_town: String
}
