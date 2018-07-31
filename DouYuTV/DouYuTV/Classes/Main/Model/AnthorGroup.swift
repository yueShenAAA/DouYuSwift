//
//  AnthorGroup.swift
//  DouYuTV
//
//  Created by l on 2018/7/22.
//  Copyright © 2018年 l. All rights reserved.
//

import UIKit
import HandyJSON

class AnthorGroup: HandyJSON {

    //该组中是房间房间信息
     var room_list : [AnthorModel]?
    //图标
    var small_icon_url:String?
    //图片
    var icon_url:String? = "home_header_phone"
    //分类标题名字
    var tag_name:String? = ""
    var push_vertical_screen:Int? = 0
    //懒加载数组
    lazy var anthorModels : [AnthorModel] = [AnthorModel]()
    
    required init() {}
    

    
    
    
    
    

}
