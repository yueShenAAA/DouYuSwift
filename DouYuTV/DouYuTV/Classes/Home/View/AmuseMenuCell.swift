//
//  AmuseMenuCell.swift
//  DouYuTV
//
//  Created by l on 2018/11/14.
//  Copyright © 2018 l. All rights reserved.
//

import UIKit
fileprivate let menuItemCellID = "menuItemCellID"
class AmuseMenuCell: UICollectionViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var groups : [AnthorGroup]? {
        didSet{
            collectionView.reloadData()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(UINib(nibName: "CollectionViewGameCell", bundle: nil), forCellWithReuseIdentifier: menuItemCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let itemW = collectionView.bounds.width/4
        let itemH = collectionView.bounds.height/2
        layout.itemSize = CGSize(width: itemW, height: itemH)
    }

}


extension AmuseMenuCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: menuItemCellID, for: indexPath) as! CollectionViewGameCell
        cell.group = groups![indexPath.item]
        return cell
    }
    
    
}
