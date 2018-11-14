//
//  RecommendViewController.swift
//  DouYuTV
//
//  Created by l on 2018/7/18.
//  Copyright © 2018年 l. All rights reserved.
//

import UIKit

private let kNormalCollectionCellIdentifier = "CollectionViewNormalCell"
private let kPrettyCollectionCellIdentifier = "CollectionViewPrettyCell"
private let kNormalHeadViewID = "CollectionHeaderView"
private let kItemMargin : CGFloat = 10 //间距
private let kItemW : CGFloat = (kScreenW - 3*kItemMargin)/2
private let kNormalItemH : CGFloat = kItemW * 3/4
private let kPrettyItemH : CGFloat = kItemW * 4/3
private let kHeadViewH : CGFloat = 50
private let kCycleViewH : CGFloat = kScreenW * 3/8
private let kGameListViewH : CGFloat = 90

class RecommendViewController: UIViewController {
    // MARK - 懒加载 viewModel 属性
    private lazy var viewModel:RecommendViewModel = RecommendViewModel()
    // MARK - 懒加载 collectionView 属性
    private lazy var collectionView : UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeadViewH)
        // MARK - 设置内边距
        layout.sectionInset = UIEdgeInsets.init(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        let collectionV = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionV.register(UINib.init(nibName: "CollectionViewNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCollectionCellIdentifier)
        collectionV.register(UINib.init(nibName: "CollectionViewPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCollectionCellIdentifier)
        collectionV.register(UINib.init(nibName: "CollectionHeaderView", bundle:nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kNormalHeadViewID)
        collectionV.dataSource = self
        collectionV.delegate = self
        collectionV.backgroundColor = UIColor.white
        // MARK - collectionV并没有随着控制器的view缩小而缩小，还是屏幕高度，所以要设置autoresizingMask（鳌头瑞赛子ing马斯克）
        collectionV.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        return collectionV
    }()
    // MARK - 懒记载 轮播视图
    private lazy var recommendCycleView : RecommendCycle = {
        let cycleView = RecommendCycle.recommendCycleView()
        cycleView.frame = CGRect.init(x: 0, y: -kCycleViewH - kGameListViewH, width:kScreenW, height: kCycleViewH)
        return cycleView
    }()
    // MARK - 懒加载
    private lazy var recommendGameListView : RecommendGameListView = {
        let gameListView = RecommendGameListView.recommendGameListView()
        gameListView.frame = CGRect.init(x: 0, y: -kGameListViewH , width: kScreenW, height: kGameListViewH)
        return gameListView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        // MARK - 设置UI界面
        setupUI()
        // MARK - 请求数据
        getDatas()
    }

}

extension RecommendViewController{
    func setupUI() {
        //1.添加collectionView
        view.addSubview(collectionView)
        //2.添加轮播试图
        collectionView.addSubview(recommendCycleView)
        //3.添加gameListView
        collectionView.addSubview(recommendGameListView)
        //3.设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets.init(top: kCycleViewH + kGameListViewH, left: 0, bottom: 0, right: 0 )
        
    }
}
// MARK - 请求数据
extension RecommendViewController{
    private func getDatas(){
        //1.请求推荐数据
        viewModel.requestData {
            self.collectionView.reloadData()
            self.recommendGameListView.groups = self.viewModel.anthorGroups
        }
        //2.请求轮播图数据
        viewModel.requestCycleData {
            self.recommendCycleView.anthorModels = self.viewModel.cycleArray
        }
    }
}

// MARK - 遵循UICollectionViewDataSource代理协议
extension RecommendViewController: UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.anthorGroups.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = viewModel.anthorGroups[section]
        return group.anthorModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.获取model数据
        let anthorModel = viewModel.anthorGroups[indexPath.section].anthorModels[indexPath.item]
        //2.获取cell
        let cell : CollectionViewBaseCell!
        
        if indexPath.section == 1 {
            //颜值
             cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCollectionCellIdentifier, for: indexPath) as! CollectionViewPrettyCell
            
        }else{
            //其他
             cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCollectionCellIdentifier, for: indexPath) as! CollectionViewNormalCell
        }
        cell.anthorModel = anthorModel
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kNormalHeadViewID, for: indexPath) as! CollectionHeaderView
        
        headView.group = viewModel.anthorGroups[indexPath.section]
        return headView
        
    }
}

// MARK - 实现UICollectionViewDelegateFlowLayout协议方法
extension RecommendViewController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1{
            return CGSize(width: kItemW, height: kPrettyItemH)
        }
        return CGSize(width: kItemW, height: kNormalItemH)
    }
}








