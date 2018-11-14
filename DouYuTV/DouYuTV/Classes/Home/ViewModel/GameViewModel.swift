//
//  GameViewModel.swift
//  DouYuTV
//
//  Created by l on 2018/11/7.
//  Copyright © 2018 l. All rights reserved.
//

import UIKit

class GameViewModel: NSObject {

    var gameDataArray : [GameModel?] = [GameModel()]
    
}

extension GameViewModel{
    func loadAllGamesData(finishedCallBack : @escaping ()->()) {
        NetworkingTools.requestData(type: MethodType.POST, URLSting: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: nil) { (result) in
            guard let resultDict = result as? [String:Any] else{ return }
            guard let dataArray = resultDict["data"] as? [[String:Any]] else{ return }
            guard let gameArray = [GameModel].deserialize(from: dataArray) else{ return }
            for gameModel in gameArray{
                self.gameDataArray.append(gameModel)
            }
            self.gameDataArray.removeFirst()
            finishedCallBack()
        }
    }
}
