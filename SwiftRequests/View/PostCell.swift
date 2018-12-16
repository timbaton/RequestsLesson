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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(post: Post) {
        tvText.text = post.text
        
        ivImage.setImageFromURl(ImageUrl: post.attachments?[0].photo?.sizes[0].url)
    }
}

extension UIImageView{
    
    func setImageFromURl(ImageUrl: String?){
        if ImageUrl != nil {
            if let url = NSURL(string: ImageUrl!) {
                if let imagedata = NSData(contentsOf: url as URL) {
                    self.image = UIImage(data: imagedata as Data)
                }
            }
        }
    }
}
