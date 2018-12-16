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
    
    var apiService: ApiService!
    var dataManager: DataManager!
    var keyProfile = "key_profile"
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
        // #warning Incomplete implementation, return the number of rows
        return posts.count
    }

    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // Configure the cell...
        let myCell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        myCell.configureCell(post: posts[indexPath.row])
        return myCell
    }
    
    func downloadPosts() {
        let profileURL = ApiService.sharedInstance.getPostsURL()
        var urlRequest = URLRequest(url: profileURL, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 10)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            print("\(String(describing: response))")
            if let error = error{
                print("\(error)")
            }
            do{
                if let data = data {
                    //                self.dataManager.saveUserProfile(data: data, key: self.keyProfile)
                    
                    if let loadedPostsString = String.init(data: data, encoding: String.Encoding.utf8) {
                        print("posts = \(loadedPostsString)")
                    }
                    
                    let decoder = JSONDecoder()
                    let downloadPosts = try! decoder.decode(PostModel.self, from: data)
                    self.posts = downloadPosts.response.items
                    print(self.posts[0].date)
                    
                     DispatchQueue.main.async {
                        self.postsTable.reloadData()
                    }
                }
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
