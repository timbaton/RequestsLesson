//
//  ViewController.swift
//  SwiftRequests
//
//  Created by Ильдар Залялов on 26/11/2018.
//  Copyright © 2018 Ильдар Залялов. All rights reserved.
//

import UIKit
import WebKit

class LoginController: UIViewController, WKNavigationDelegate {
    let key_token = "access_token"
    let key_id = "user_id"
    let mainSegue = "mainSegue"
    
    @IBOutlet weak var vkWebView: WKWebView!
    
//    @IBOutlet weak var tvLabel: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        vkWebView.navigationDelegate = self
        let url = ApiService.sharedInstance.login_url

        vkWebView.load(URLRequest(url: url!))
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        if let currentUrl = webView.url, currentUrl.absoluteString.contains(key_token) {
            let url = currentUrl.absoluteString.replacingOccurrences(of: "blank.html#", with: "?")
            
            var response = [String:String]()
            if let queryItems = URLComponents(url: URL(string: url)!, resolvingAgainstBaseURL: false)!.queryItems {
                for item in queryItems {
                    response[item.name] = item.value!
                }
                AuthService.sharedInstance.saveUserSettings(token: response[key_token]!, id: response[key_id]!)
                performSegue(withIdentifier: mainSegue, sender: self)
            }
        }
    }
}
