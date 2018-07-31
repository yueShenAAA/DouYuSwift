//
//  AnthorModel.swift
//  DouYuTV
//
//  Created by l on 2018/7/22.
//  Copyright © 2018年 l. All rights reserved.
//

import UIKit
import HandyJSON

class AnthorModel: HandyJSON {
    //房间id
    var room_id : Int? = 0
    //游戏名字
    var game_name:String? = ""
    //房间图片
    var vertical_src:String? = ""
    //判断手机直播 1 还是电脑直播 0
    var isVertical:Int? = 0
    //房间名字
    var room_name:String? = ""
    //主播昵称
    var nickname:String? = ""
    //观看人数
    var online:Int? = 0
    //所在城市
     var anchor_city:String? = ""
    
    required init() {}
    
}
