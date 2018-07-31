//
//  CollectionViewCycleCell.swift
//  DouYuTV
//
//  Created by l on 2018/7/30.
//  Copyright © 2018年 l. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionViewCycleCell: UICollectionViewCell {
    var cycleModel : RecommendCycleModel?{
        didSet{
            guard let urlStr = cycleModel?.pic_url else {
                return
            }
            
            cycleImageV.kf.setImage(with: ImageResource(downloadURL: URL.init(string: urlStr)!))
            titleLab.text = cycleModel?.title
        }
    }
    @IBOutlet weak var cycleImageV: UIImageView!
    
    @IBOutlet weak var titleLab: UILabel!
    

}
