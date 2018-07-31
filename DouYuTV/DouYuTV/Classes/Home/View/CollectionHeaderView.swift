//
//  CollectionHeaderView.swift
//  DouYuTV
//
//  Created by l on 2018/7/18.
//  Copyright © 2018年 l. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionHeaderView: UICollectionReusableView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var headImageView: UIImageView!
    var group : AnthorGroup?{
        didSet {
            guard let groupModel = group else {
                return
            }
            
            titleLabel.text = groupModel.tag_name
            if (groupModel.icon_url?.hasPrefix("http"))! {
                headImageView.kf.setImage(with: ImageResource(downloadURL: URL.init(string: groupModel.small_icon_url!)!))
            }else{
                headImageView.image = UIImage(named: groupModel.icon_url!)
            }
            
        }
    }
    
    
}
