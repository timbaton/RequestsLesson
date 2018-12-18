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
    @IBOutlet weak var etNewPost: UITextView!
    
    var requestManager: RequestManagerProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        requestManager = RequestManager.sharedInstance as RequestManagerProtocol
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
        requestManager.downloadUserProfile(completionHandler: { (success) in
            if success{
                self.showProfile()
            }
        })
    }
    @IBAction func btnNewPost(_ sender: Any) {
        print(etNewPost.text)
        requestManager.postNewPost(message: etNewPost.text, completionHandler: { (success) in
            if success{
                DispatchQueue.main.async {
                    self.showMessage(message: "Создан новый пост!")
                    self.etNewPost.text = ""
                }
            }
        })
    }
    
    func showMessage(message: String) {
        // create the alert
        let alert = UIAlertController(title: "Post", message: message, preferredStyle: .alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true)
    }
}
