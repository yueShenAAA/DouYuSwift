//
//  CollectionViewPrettyCell.swift
//  DouYuTV
//
//  Created by l on 2018/7/18.
//  Copyright © 2018年 l. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionViewPrettyCell: CollectionViewBaseCell {

    @IBOutlet weak var cityBtn: UIButton!
    
    
    
    override var anthorModel : AnthorModel? {
        didSet{
           
            super.anthorModel = anthorModel
            
            cityBtn.setTitle(anthorModel?.anchor_city, for: .normal)
        }
    }
    

}
