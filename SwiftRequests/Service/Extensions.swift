//
//  Extensions.swift
//  SwiftRequests
//
//  Created by Тимур Бадретдинов on 17/12/2018.
//  Copyright © 2018 Ильдар Залялов. All rights reserved.
//

import Foundation
import UIKit

public extension UIImageView{
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
