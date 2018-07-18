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

class RecommendViewController: UIViewController {
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
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        // MARK - 设置UI界面
        self.setupUI()
    }

}

extension RecommendViewController{
    func setupUI() {
        view.addSubview(collectionView)
    }
}
// MARK - 遵循UICollectionViewDataSource代理协议
extension RecommendViewController: UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 8
        }
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.获取cell
        var cell : UICollectionViewCell!
        
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCollectionCellIdentifier, for: indexPath)
        }else{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCollectionCellIdentifier, for: indexPath)

        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kNormalHeadViewID, for: indexPath)
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








