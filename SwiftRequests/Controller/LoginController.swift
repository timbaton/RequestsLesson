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
//    let key_id = "user_id"
    let mainSegue = "mainSegue"
    var authService: AuthService!
    var apiService: ApiService!
    @IBOutlet weak var vkWebView: WKWebView!
    
    
    
//    @IBOutlet weak var tvLabel: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        authService = AuthService.sharedInstance
        apiService = ApiService.sharedInstance
        
        vkWebView.navigationDelegate = self
        // Do any additional setup after loading the view, typically from a nib.
        
        let url = apiService.login_url

        vkWebView.load(URLRequest(url: url!))
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        if let currentUrl = webView.url, currentUrl.absoluteString.contains(key_token) {
            let url = currentUrl.absoluteString.replacingOccurrences(of: "blank.html#", with: "?")
            
            var credentials = [String:String]()
            if let queryItems = URLComponents(url: URL(string: url)!, resolvingAgainstBaseURL: false)!.queryItems {
                for item in queryItems {
                    credentials[item.name] = item.value!
                }
                authService.saveUserSettings(token: credentials[key_token]!, id: credentials[key_id]!)
                performSegue(withIdentifier: mainSegue, sender: self)
            }
        }
    }
}
