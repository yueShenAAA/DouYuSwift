//
//  FunnyViewController.swift
//  DouYuTV
//
//  Created by l on 2018/11/15.
//  Copyright © 2018 l. All rights reserved.
//

import UIKit
private let kNormalCollectionCellIdentifier = "CollectionViewNormalCell"
private let kItemMargin : CGFloat = 10 //间距
private let kItemW : CGFloat = (kScreenW - 3*kItemMargin)/2
private let kNormalItemH : CGFloat = kItemW * 3/4

class FunnyViewController: BaseViewController {

    // MARK:懒加载
    fileprivate lazy var collectionView : UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        // MARK - 设置内边距
        layout.sectionInset = UIEdgeInsets.init(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        let collectionV = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionV.register(UINib.init(nibName: "CollectionViewNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCollectionCellIdentifier)
        collectionV.dataSource = self
        collectionV.delegate = self
        collectionV.backgroundColor = UIColor.white
        // MARK - collectionV并没有随着控制器的view缩小而缩小，还是屏幕高度，所以要设置autoresizingMask（鳌头瑞赛子ing马斯克）
        collectionV.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        return collectionV
        }()
    fileprivate var funnyViewModel : FunnyViewModel = FunnyViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }

}
// MARK:请求数据
extension FunnyViewController{
    fileprivate func loadData(){
        funnyViewModel.loadFunnyData {
            self.collectionView.reloadData()
            //隐藏loading，显示界面
            self.hiddenLoad()
        }
    }
}
// MARK:搭建UI界面
extension FunnyViewController{
    //重写父类方法
    override func setupUI(){
        //1.添加colloectionView
        view.addSubview(collectionView)
        //2.设置collectionView内边据
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        //3.把collectionView赋值给父类，用于隐藏和显示的控制
        contentView = collectionView
        //4.调用父类方法
        super.setupUI()
        
    }
}
// MARK:实现UICollectionViewDataSource 代理协议
extension FunnyViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return funnyViewModel.funnyDataArray?.count ?? 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCollectionCellIdentifier, for: indexPath) as! CollectionViewNormalCell
        cell.anthorModel = funnyViewModel.funnyDataArray![indexPath.row]
        
        return cell
    }
    
    
    
}


// MARK:遵守UICollectionViewDelegate代理协议
extension FunnyViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let anthor = funnyViewModel.funnyDataArray?[indexPath.item]
        //判断是手机直播还是电脑直播
        anthor?.isVertical == 0 ?pushNormalRoomViewController():presentShowRoomViewController()
    }
}

extension FunnyViewController  {
    private func presentShowRoomViewController(){
        self.present(RoomShowViewController(), animated: true, completion: nil)
    }
    
    private func pushNormalRoomViewController(){
        self.navigationController?.pushViewController(RoomNormalViewController(), animated: true)
    }
}
