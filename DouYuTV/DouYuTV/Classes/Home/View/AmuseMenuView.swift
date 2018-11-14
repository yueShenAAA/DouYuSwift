//
//  AmuseMenuView.swift
//  DouYuTV
//
//  Created by l on 2018/11/13.
//  Copyright © 2018 l. All rights reserved.
//

import UIKit
fileprivate let meunCellID = "MenuCellID"
class AmuseMenuView: UIView {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    var groups : [AnthorGroup]?{
        didSet{
            collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib.init(nibName: "AmuseMenuCell", bundle: nil), forCellWithReuseIdentifier: meunCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        
    }
    
}

extension AmuseMenuView {
   class func amuseMenuView() -> AmuseMenuView {
        return Bundle.main.loadNibNamed("AmuseMenuView", owner: nil, options: nil)?.first as! AmuseMenuView
    }
}

extension AmuseMenuView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //计算有几页数据
        if groups == nil { return 0 }
        pageControl.numberOfPages = ((groups?.count)! - 1)/8 + 1
        return ((groups?.count)! - 1)/8 + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: meunCellID, for: indexPath) as! AmuseMenuCell
        //把每页的数据传给cell
        self.getDataWitCell(cell: cell, indexPath: indexPath)
        return cell
        
    }
    
    func getDataWitCell(cell:AmuseMenuCell,indexPath:IndexPath) {
        //0页 0 ~ 7  8 ~ 15  16 ~ 23 ...
        let startIndex = indexPath.item * 8
        var endIndex = (indexPath.item + 1)*8 - 1
        if endIndex > (groups?.count)! - 1 {
            endIndex = (groups?.count)! - 1
        }
        cell.groups = Array(groups![startIndex...endIndex])
    }
    
}

extension AmuseMenuView : UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.width)
    }
}
