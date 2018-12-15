//
//  ProfileController.swift
//  SwiftRequests
//
//  Created by Тимур Бадретдинов on 15/12/2018.
//  Copyright © 2018 Ильдар Залялов. All rights reserved.
//

import UIKit

class ProfileController: UIViewController {
    var apiService: ApiService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiService = ApiService.sharedInstance
        
        let profileURL = apiService.getProfileURL()
        var urlRequest = URLRequest(url: profileURL, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 10)
        urlRequest.httpMethod = "GET"
        
        let session = URLSession.shared

        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            
            if error != nil{
                print("\(String(describing: error))")
                
            } else if let data = data {
            let stringData = String.init(data: data, encoding: String.Encoding.utf8)
                let model = try!
                    JSONDecoder().decode(ProfileModel.self, from: data)

                print(stringData)
                print("user = \(String(describing: model))")
            }
        }
        task.resume()
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
