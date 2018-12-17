//
//  HistoriesController.swift
//  SwiftRequests
//
//  Created by Тимур Бадретдинов on 16/12/2018.
//  Copyright © 2018 Ильдар Залялов. All rights reserved.
//

import UIKit


class HistoriesController: UIViewController, UITextViewDelegate, UITableViewDataSource {
    @IBOutlet weak var postsTable: UITableView!
    
    private var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postsTable.estimatedRowHeight = 100
        downloadPosts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Configure the cell
        let myCell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        
        myCell.configureCell(post: posts[indexPath.row])
//            myCell.isHidden = true
        return myCell
    }
    
    func downloadPosts() {
        let requestManager = RequestManager.sharedInstance as RequestManagerProtocol
        requestManager.downloadPosts(completionHandler: { (success) in
            if success{
                self.posts = DataManager.sharedInstance.getPosts()
                DispatchQueue.main.async {
                    self.postsTable.reloadData()
                }
            }
        })
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
