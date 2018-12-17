//
//  RequestManagerProtocol.swift
//  SwiftRequests
//
//  Created by Тимур Бадретдинов on 17/12/2018.
//  Copyright © 2018 Ильдар Залялов. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ success: Bool) -> Void

protocol RequestManagerProtocol {    
    func downloadFileFromURL(url: URLRequest, completionHandler: @escaping (Bool) -> Void)
}
