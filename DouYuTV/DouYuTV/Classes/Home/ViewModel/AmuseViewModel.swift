//
//  AmuseViewModel.swift
//  DouYuTV
//
//  Created by l on 2018/11/9.
//  Copyright © 2018 l. All rights reserved.
//

import UIKit

class AmuseViewModel{

    //懒加载属性
    lazy var anthorGroups:[AnthorGroup]? = [AnthorGroup]()
    //请求数据
    func loadAmuseData(finishedCallBack : @escaping ()->()) {
        
        NetworkingTools.requestData(type: MethodType.GET, URLSting: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", parameters: nil) { (result) in
            //1.把result转成字典类型
            guard let resultDict = result as? [String:NSObject] else{return}
            //2.获取数组
            guard let arrayData = resultDict["data"] as? [[String:NSObject]] else{return}
            
            //3.遍历数组，获取字典，将字典转成模型
            guard let arrayModel = [AnthorGroup].deserialize(from: arrayData) else{ return }
            for model in arrayModel{
                self.anthorGroups?.append(model!)
            }
        
            finishedCallBack()
        }
    }
}
