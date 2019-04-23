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

class AmuseViewController: BaseViewController {
    
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
        collectionV.register(UINib.init(nibName: "CollectionHeaderView", bundle:nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kNormalHeadViewID)
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
    //重写父类方法
    override func setupUI() {
        //1.添加collectionView
        view.addSubview(collectionView)
        //2.collectionView添加头部视图
        collectionView.addSubview(amuseMenuView)
        //3.设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top: kAmuseMenuViewH, left: 0, bottom: 0, right: 0)
        //4.把collectionView赋值给父类
        contentView = collectionView
        //5.调用父类方法
        super.setupUI()
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
            //隐藏loading，显示界面
            self.hiddenLoad()
        }
    }
}
// MARK:实现UICollectionViewDataSource代理协议
extension AmuseViewController:UICollectionViewDataSource{
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
// MARK:遵守UICollectionViewDelegate代理协议
extension AmuseViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let anthor = amuseVM.anthorGroups?[indexPath.section].room_list?[indexPath.item]
        //判断是手机直播还是电脑直播
        anthor?.isVertical == 0 ?pushNormalRoomViewController():presentShowRoomViewController()
    }
}

extension AmuseViewController  {
    private func presentShowRoomViewController(){
        self.present(RoomShowViewController(), animated: true, completion: nil)
    }
    
    private func pushNormalRoomViewController(){
        self.navigationController?.pushViewController(RoomNormalViewController(), animated: true)
    }
}
