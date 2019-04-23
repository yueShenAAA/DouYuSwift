//
//  FunnyViewModel.swift
//  DouYuTV
//
//  Created by l on 2018/11/15.
//  Copyright © 2018 l. All rights reserved.
//

import UIKit

class FunnyViewModel {
    var funnyDataArray : [AnthorModel]? = [AnthorModel]()
    func loadFunnyData(finishedCallBack: @escaping ()->())  {
        
        NetworkingTools.requestData(type: MethodType.GET, URLSting: "http://capi.douyucdn.cn/api/v1/getColumnRoom/2", parameters: ["limit":"30","offset":"0"]) { (result) in
            //http://capi.douyucdn.cn/api/v1/getColumnRoom/2?limit==30&offset==0
            guard let resultDict = result as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            self.funnyDataArray = [AnthorModel].deserialize(from: dataArray) as? [AnthorModel]
            finishedCallBack()
        }
    }
    
}
