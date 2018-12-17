//
//  ProfileController.swift
//  SwiftRequests
//
//  Created by Тимур Бадретдинов on 15/12/2018.
//  Copyright © 2018 Ильдар Залялов. All rights reserved.
//

import UIKit

class ProfileController: UIViewController {
    @IBOutlet weak var tvName: UILabel!
    @IBOutlet weak var tvStatus: UILabel!
    @IBOutlet weak var tvBDay: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadProfile()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showProfile() {
        let profile: ProfileModel? = DataManager.sharedInstance.getUserProfile()
        
        DispatchQueue.main.async {
            self.tvBDay.text = profile?.response.bdate
            self.tvName.text = profile?.response.first_name
            self.tvStatus.text = profile?.response.status
        }
    }
    
    func loadProfile() {
        let requestManager = RequestManager.sharedInstance as RequestManagerProtocol
        
        requestManager.downloadUserProfile(completionHandler: { (success) in
            if success{
                self.showProfile()
            }
        })
    }
}
