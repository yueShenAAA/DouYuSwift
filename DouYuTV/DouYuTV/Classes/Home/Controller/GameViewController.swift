//
//  GameViewController.swift
//  DouYuTV
//
//  Created by l on 2018/11/7.
//  Copyright © 2018 l. All rights reserved.
//

import UIKit

fileprivate let kEdgeMargin : CGFloat = 10
fileprivate let kItemW : CGFloat = (kScreenW - 2 * kEdgeMargin)/3
fileprivate let kItemH : CGFloat = kItemW*6/5
fileprivate let kHeaderH : CGFloat = 50
fileprivate let kGameHeadH:CGFloat = 90
fileprivate let kCellID = "CollectionViewGameCell"
fileprivate let kConllectionViewHeadID = "CollectionHeaderView"

class GameViewController: BaseViewController {
// MARK:懒加载属性
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        //1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kEdgeMargin, bottom: kStatusBarH+kNavigationBarH + 40, right: kEdgeMargin)
        //2.创建collectionView
        let collectionView = UICollectionView(frame:self.view.bounds , collectionViewLayout: layout)
        collectionView.register(UINib.init(nibName: "CollectionViewGameCell", bundle: nil), forCellWithReuseIdentifier: kCellID)
        
        collectionView.register(UINib.init(nibName:"CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kConllectionViewHeadID)
        
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        return collectionView
    }()
    
    fileprivate lazy var viewModel : GameViewModel = GameViewModel()
    
    fileprivate lazy var headView : CollectionHeaderView = {
        let head = CollectionHeaderView.collectionHeadView()
        head.frame = CGRect(x: 0, y: -(kHeaderH + kGameHeadH), width: kScreenW, height: kHeaderH)
        head.titleLabel.text = "常用"
        head.headImageView.image = UIImage(named: "Img_orange")
        head.moreBtn.isHidden = true
        return head
    }()
    
    fileprivate lazy var gameView : RecommendGameListView = {
        let gameV = RecommendGameListView.recommendGameListView()
        gameV.frame = CGRect(x: 0, y: -kGameHeadH, width: kScreenW, height: kGameHeadH)
        return gameV
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //1.创建UI界面
        setupUI()
        //2.请求数据
        getGameData()
    }
    
    
}
// MARK:搭建UI界面
extension GameViewController{
    //重写父类方法
    override func setupUI(){
        //1.添加collectionView
        view.addSubview(collectionView)
        //2.添加collectionViewHead
        collectionView.addSubview(headView)
        collectionView.addSubview(gameView)
        //3.设置collectionView 的内边距
        collectionView.contentInset = UIEdgeInsets(top: kHeaderH + kGameHeadH, left: 0, bottom: 0, right: 0)
        //4.把collectionView赋值给父类
        contentView = collectionView
        //5.调用父类方法
        super.setupUI()
    }
}
// MARK:数据请求
extension GameViewController{
    fileprivate func getGameData(){
        viewModel.loadAllGamesData {
            //1.展示全部游戏
            self.collectionView.reloadData()
            //2.展示常用游戏
            self.gameView.isHome = false
            self.gameView.games = Array(self.viewModel.gameDataArray[0..<10]) as? [GameModel]
            //3.隐藏loading，显示界面
            self.hiddenLoad()
        }
    }
}
// MARK:遵守UICollectionViewDataSource数据源&代理
extension GameViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.gameDataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCellID, for: indexPath) as! CollectionViewGameCell
        let model = viewModel.gameDataArray[indexPath.row]
        cell.gameModel = model
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let collectionViewHead = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kConllectionViewHeadID, for: indexPath) as! CollectionHeaderView
        collectionViewHead.titleLabel.text = "全部"
        collectionViewHead.headImageView.image = UIImage(named: "Img_orange")
        collectionViewHead.moreBtn.isHidden = true
        return collectionViewHead
        
    }
    
}
