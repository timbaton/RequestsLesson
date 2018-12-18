//
//  PostCell.swift
//  SwiftRequests
//
//  Created by Тимур Бадретдинов on 16/12/2018.
//  Copyright © 2018 Ильдар Залялов. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    @IBOutlet weak var tvText: UILabel!
    @IBOutlet weak var ivImage: UIImageView!
    @IBOutlet weak var tvLikes: UILabel!
    @IBOutlet weak var tvComments: UILabel!
    @IBOutlet weak var tvReposts: UILabel!
    @IBOutlet weak var btnLike: UIButton!
    
    var postId: Int!
    var sourceId: Int!
    var isLiked: Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(post: Post) {
        postId = post.post_id
        sourceId = post.source_id
        isLiked = post.likes?.user_likes
        if isLiked == 1{
            btnLike.setImage(#imageLiteral(resourceName: "like_active"), for: .normal)
        }
        tvText.text = post.text
        tvLikes.text = String("\(post.likes?.count ?? 0)")
        tvComments.text = String("\(post.comments?.count ?? 0)")
        tvReposts.text = String("\(post.reposts?.count ?? 0)")
        ivImage.setImageFromURl(ImageUrl: post.attachments?[0].photo?.sizes[0].url)
    }
    
    @IBAction func btnLike(_ sender: Any) {
        let requestManager = RequestManager.sharedInstance as RequestManagerProtocol
        
        if isLiked == 0 {
            isLiked = 1
            tvLikes.text = String(Int(tvLikes.text!)! + 1)
            btnLike.setImage(#imageLiteral(resourceName: "like_active"), for: .normal)
            
            requestManager.likePost(itemId: String(postId), sourceId: String(sourceId))
            
        } else {
            isLiked = 0
            tvLikes.text = String(Int(tvLikes.text!)! - 1)
            btnLike.setImage(#imageLiteral(resourceName: "like"), for: .normal)
            
            requestManager.dislikePost(itemId: String(postId), sourceId: String(sourceId))
        }
        print("button with \(postId) id clicked")
        print("is like = \(isLiked)")
    }
}
