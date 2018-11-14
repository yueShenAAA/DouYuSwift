//
//  AmuseViewController.swift
//  DouYuTV
//
//  Created by l on 2018/11/9.
//  Copyright © 2018 l. All rights reserved.
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
private let kAmuseMenuViewH : CGFloat = 200

class AmuseViewController: UIViewController {
    
    // MARK:懒加载属性
    fileprivate lazy var collectionView : UICollectionView = { [unowned self] in
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
    fileprivate lazy var amuseVM : AmuseViewModel = AmuseViewModel()
    fileprivate lazy var amuseMenuView : AmuseMenuView = {
        let amuseView = AmuseMenuView.amuseMenuView()
        amuseView.frame = CGRect(x: 0, y: -kAmuseMenuViewH, width: kScreenW, height: kAmuseMenuViewH)
        return amuseView
    }()
    // MARK:系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadAmuseData()
    }

}

// MARK:搭建UI界面
extension AmuseViewController{
    fileprivate func setupUI() {
        view.addSubview(collectionView)
        collectionView.addSubview(amuseMenuView)
        collectionView.contentInset = UIEdgeInsets(top: kAmuseMenuViewH, left: 0, bottom: 0, right: 0)
    }
}
// MARK:请求数据
extension AmuseViewController{
    
    fileprivate func loadAmuseData()  {
        
        amuseVM.loadAmuseData {
            self.collectionView.reloadData()
            var newGroups = self.amuseVM.anthorGroups
            newGroups?.removeFirst()
            self.amuseMenuView.groups = newGroups
        }
    }
}
// MARK:实现UICollectionViewDataSource&UICollectionViewDelegate 代理协议
extension AmuseViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return amuseVM.anthorGroups?[section].room_list?.count ?? 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        
        return amuseVM.anthorGroups?.count ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCollectionCellIdentifier, for: indexPath) as! CollectionViewNormalCell
        cell.anthorModel = amuseVM.anthorGroups?[indexPath.section].room_list?[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kNormalHeadViewID, for: indexPath) as? CollectionHeaderView
        
        headView?.group = amuseVM.anthorGroups?[indexPath.section]
        
        return headView!
    }
    
    
}
