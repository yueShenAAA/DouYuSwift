//
//  RecommendGameListView.swift
//  DouYuTV
//
//  Created by l on 2018/7/30.
//  Copyright © 2018年 l. All rights reserved.
//

import UIKit
private let GameCellID = "UICollectionViewCell"
class RecommendGameListView: UIView {
    @IBOutlet weak var collectionView: UICollectionView!
    //判断是否是首页推荐界面用的
    var isHome : Bool = true
    
    var groups : [AnthorGroup]?{
        didSet{
            groups?.removeFirst()
            groups?.removeFirst()
            let moreGroups = AnthorGroup()
            moreGroups.tag_name = "更多"
            groups?.append(moreGroups)
            collectionView.reloadData()
        }
    }
    
    var games : [GameModel]?{
        didSet{
            collectionView.reloadData()
        }
    }
    
    
    
    override func awakeFromNib() {
        //让本身不随着父控件的拉伸尔拉伸
        autoresizingMask = .flexibleBottomMargin
        //注册cell
        collectionView.register(UINib.init(nibName: "CollectionViewGameCell", bundle: nil), forCellWithReuseIdentifier: GameCellID)
    }
    
    func recommendGameListView() -> RecommendGameListView {
        return Bundle.main.loadNibNamed("RecommendGameListView", owner: nil, options: nil)?.first as! RecommendGameListView
    }

}

extension RecommendGameListView{
    
   class func recommendGameListView() -> RecommendGameListView {
        
        return Bundle.main.loadNibNamed("RecommendGameListView", owner: nil, options: nil)?.first as! RecommendGameListView
        
    }
}

// MARK - 实现UICollectionViewDataSource协议
extension RecommendGameListView : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if isHome {
            return groups?.count ?? 0
        }else{
            return games?.count ?? 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView .dequeueReusableCell(withReuseIdentifier: GameCellID, for: indexPath) as! CollectionViewGameCell
        
        if isHome {
            let group = groups![indexPath.item]
            cell.group = group
            
        }else{
            let gameData = games![indexPath.item]
            cell.gameModel = gameData
        }
        
        return cell
    }
    
    
}
