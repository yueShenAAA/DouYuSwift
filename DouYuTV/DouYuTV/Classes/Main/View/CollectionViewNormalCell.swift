//
//  CollectionViewNormalCell.swift
//  DouYuTV
//
//  Created by l on 2018/7/18.
//  Copyright © 2018年 l. All rights reserved.
//

import UIKit

class CollectionViewNormalCell: CollectionViewBaseCell {

    @IBOutlet weak var detailLabel: UILabel!
    
    override var anthorModel : AnthorModel? {
            didSet{
                    super.anthorModel = anthorModel
                    detailLabel.text = anthorModel?.nickname
                }
    }
    
    
}
