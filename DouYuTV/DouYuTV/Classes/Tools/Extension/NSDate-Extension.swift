//
//  NSDate-Extension.swift
//  DouYuTV
//
//  Created by l on 2018/7/21.
//  Copyright © 2018年 l. All rights reserved.
//

import Foundation
extension NSDate{
    class func getCurrentTime() -> String{
        let nowDate = NSDate()
        let interval = nowDate.timeIntervalSince1970
        
        return "\(interval)"
    }
}
