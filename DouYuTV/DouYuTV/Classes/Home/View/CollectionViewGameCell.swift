//
//  CollectionViewGameCell.swift
//  DouYuTV
//
//  Created by l on 2018/7/31.
//  Copyright © 2018年 l. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionViewGameCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleImageV: UIImageView!
    var group : AnthorGroup?{
        didSet{
            guard let groupData = group else {
                return
            }
            
            titleLabel.text = groupData.tag_name
            
            if groupData.icon_url == "" {
                return
            }
            titleImageV.kf.setImage(with: ImageResource(downloadURL: URL.init(string: groupData.icon_url ?? "")!, cacheKey: nil), placeholder: Image(named: "home_more_btn"))
        }
    }
    
    var gameModel: GameModel?{
        didSet{
            guard let model = gameModel else{ return }
            titleLabel.text = model.tag_name
            titleImageV.kf.setImage(with:ImageResource(downloadURL: URL(string: model.pic_url ?? "")!,cacheKey: nil), placeholder: Image(named: "home_more_btn"))
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
