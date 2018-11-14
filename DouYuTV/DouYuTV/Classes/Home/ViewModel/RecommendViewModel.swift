//
//  RecommendViewModel.swift
//  DouYuTV
//
//  Created by l on 2018/7/21.
//  Copyright © 2018年 l. All rights reserved.
//

import UIKit
class RecommendViewModel:NSObject{
    
    //懒加载属性
    lazy var anthorGroups:[AnthorGroup] = [AnthorGroup]()
    //热门
    private lazy var hotGroup : AnthorGroup = AnthorGroup()
    //颜值
    private lazy var prettyGroup : AnthorGroup = AnthorGroup()
    //轮播图
    lazy var cycleArray : [RecommendCycleModel] = [RecommendCycleModel]()
}
// MARK - 请求直播数据
extension RecommendViewModel{
    func requestData(finishedCallBack:@escaping () -> ())  {
        //定义参数
        let prameters = ["limit":"4","offset":"0","time":NSDate.getCurrentTime()]
        //创建一个组
        let dGroup = DispatchGroup()
        
        
        //请求第一部分推荐数据
        dGroup.enter()
        NetworkingTools.requestData(type: .GET, URLSting: "http://capi.douyucdn.cn/api/v1/getBigDataRoom", parameters: ["time":NSDate.getCurrentTime()]) { (result) in
            //1.将reult转成字典
            guard let resultDict = result as? [String : NSObject] else{return}
            //2.获取数组
            guard let arrayData = resultDict["data"] as? [[String : NSObject]] else{return}
            //3.遍历数组 字典转模型
               //3.1 设置组的属性
                self.hotGroup.tag_name = "热门"
                self.hotGroup.icon_url = "home_header_hot"
                //3.2 获取主播数据
                if let anthorModels = [AnthorModel].deserialize(from: arrayData){
                    for anthorModel in anthorModels{
                        self.hotGroup.anthorModels.append(anthorModel!)
                    }
                    
                }
                //3.4 离开组
               dGroup.leave()
 
        }
        
        //请求颜值数据
        dGroup.enter()
        NetworkingTools.requestData(type: .GET, URLSting: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: prameters) { (result) in
            //1.把result转成字典
            guard let resultDict = result as? [String:NSObject] else{return}
            //2.获取数组
            guard let arrayData = resultDict["data"] as? [[String:NSObject]] else{return}
            //3.遍历数组 字典转模型
                //3.1 设置组的属性
                self.prettyGroup.tag_name = "颜值"
                self.prettyGroup.icon_url = "home_header_phone"
                //3.2 获取主播数据
                if let anthorModels = [AnthorModel].deserialize(from: arrayData){
                    for anthorModel in anthorModels{
                        self.prettyGroup.anthorModels.append(anthorModel!)
                    }
                    
                }

                //3.4 离开组
                dGroup.leave()
        }
        //请求后面部分游戏数据
        dGroup.enter()
        NetworkingTools.requestData(type: .GET, URLSting: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: prameters) { (result) in
            //1.把result转成字典类型
            guard let resultDict = result as? [String:NSObject] else{return}
            //2.获取数组
            guard let arrayData = resultDict["data"] as? [[String:NSObject]] else{return}
            //3.遍历数组，获取字典，将字典转成模型
            if let groups = [AnthorGroup].deserialize(from: arrayData){
                for group in groups{
                    let anthorModels:[AnthorModel]? = group?.room_list
                    for anthorModel in anthorModels!{
                        group?.anthorModels.append(anthorModel)
                    }
                    
                    self.anthorGroups.append(group!)
                }
            }
            //3.4 离开组
            dGroup.leave()
            
        }
        
        
        dGroup.notify(queue: DispatchQueue.main) {
            self.anthorGroups.insert(self.prettyGroup, at: 0)
            self.anthorGroups.insert(self.hotGroup, at: 0)
            finishedCallBack()
        }
        
    }
}
// MARK - 请求轮播图数据
extension RecommendViewModel{
    func requestCycleData(finishCallBack:@escaping () -> ()){
        
        NetworkingTools.requestData(type: .GET, URLSting: "http://www.douyutv.com/api/v1/slide/6", parameters: ["version":"2.300"]) { (result) in
            //1.将result转成字典
            guard let resultDict = result as? [String : NSObject] else {return}
            //2.获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {return}
            //3.便利数组，字典转模型,将模型存入数组
            if let modelArray = [RecommendCycleModel].deserialize(from: dataArray){
                for model in modelArray{
                    self.cycleArray.append(model!)
                }
            }
            
            finishCallBack()
        }
    }
    
    
}
