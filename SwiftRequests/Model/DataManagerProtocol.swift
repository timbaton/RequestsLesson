//
//  DataManagerProtocol.swift
//  SwiftRequests
//
//  Created by Тимур Бадретдинов on 14/12/2018.
//  Copyright © 2018 Ильдар Залялов. All rights reserved.
//

import Foundation

protocol DataManagerProtocol {
    
    //MARK: - Профиль пользователя
    
    
    /// Сохраняем токен пользователя
    ///
    /// - Parameter token: токен
    func saveUserToken(with token: String)
    
    func getUserToken() -> String?
}
