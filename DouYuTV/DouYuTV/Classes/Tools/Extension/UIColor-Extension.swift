//
//  UIColor-Extension.swift
//  DouYuTV
//
//  Created by l on 2018/7/16.
//  Copyright © 2018年 l. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(r:CGFloat,g:CGFloat,b:CGFloat) {
        
         self.init(red: r/255.0, green: g/255.0, blue:b/255.0, alpha: 1)
    }
    
}
