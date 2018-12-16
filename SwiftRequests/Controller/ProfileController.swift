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
    var dataManager: DataManager!
    var keyProfile = "key_profile"
    
    @IBOutlet weak var tvName: UILabel!
    @IBOutlet weak var tvStatus: UILabel!
    @IBOutlet weak var tvBDay: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiService = ApiService.sharedInstance
        dataManager = DataManager.sharedInstance
        
//        showProfile()
        loadProfile()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showProfile(data: Data) {
        var profile: ProfileModel? = nil
        let decoder = JSONDecoder()
        if let loadedPerson = try! decoder.decode(ProfileModel?.self, from: data) {
            print(loadedPerson.response.first_name)
            profile = loadedPerson
        }
        print(profile)

        DispatchQueue.main.async {
            self.tvBDay.text = profile?.response.bdate
            self.tvName.text = profile?.response.first_name
            self.tvStatus.text = profile?.response.status
        }
    }
    
    func getProfileFromDB() -> ProfileModel? {
        var profile: ProfileModel? = nil
        let savedProfile = UserDefaults.standard.data(forKey: keyProfile)
        if savedProfile != nil {
            let decoder = JSONDecoder()
            if let loadedPerson = try! decoder.decode(ProfileModel?.self, from: savedProfile!) {
                print(loadedPerson.response.first_name)
                profile = loadedPerson
            }
        } else {
            loadProfile()
        }
        return profile
    }
    
    func loadProfile() {
        let profileURL = apiService.getProfileURL()
        var urlRequest = URLRequest(url: profileURL, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 10)
        
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            print("\(String(describing: response))")
            if let error = error{
                print("\(error)")
            }
            if let data = data {
                self.dataManager.saveUserProfile(data: data, key: self.keyProfile)
                
                let decoder = JSONDecoder()
                if let loadedPerson = String.init(data: data, encoding: String.Encoding.utf8) {
                    print(loadedPerson)
                }
                self.showProfile(data: data)
            }
        }
        task.resume()
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
