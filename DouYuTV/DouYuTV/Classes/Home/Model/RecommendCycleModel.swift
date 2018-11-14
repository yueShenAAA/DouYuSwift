//
//  RecommendCycleModel.swift
//  DouYuTV
//
//  Created by l on 2018/7/30.
//  Copyright © 2018年 l. All rights reserved.
//

import UIKit
import HandyJSON

class RecommendCycleModel: HandyJSON {
    var title : String? = ""
    var pic_url : String? = ""
    var tv_pic_url : String? = ""
    var room : [String : NSObject]?{
        didSet{
            let roomModel = AnthorModel.deserialize(from: room)
            anthor = roomModel
        }
    }
    
    var anthor : AnthorModel?
    
    required init() {}
}
