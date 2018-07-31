//
//  CollectionViewBaseCell.swift
//  DouYuTV
//
//  Created by l on 2018/7/27.
//  Copyright © 2018年 l. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionViewBaseCell: UICollectionViewCell {
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var onLineNum: UIButton!
    
    
    
    var anthorModel : AnthorModel? {
        didSet{
            guard let anthor = anthorModel else {
                return
            }
            //显示在线人数
            var onLineNumStr : String = ""
            if anthor.online! >= 10000 {
                onLineNumStr = "\(String(describing: (Int(anthor.online!/10000))))万在线"
            }else{
                onLineNumStr = "\(String(describing: (anthor.online)!))在线"
            }
            onLineNum.setTitle(onLineNumStr, for: .normal)
            titleLabel.text = anthor.room_name
            titleImage.kf.setImage(with: ImageResource(downloadURL: URL(string: anthor.vertical_src!)!))
        }
    }
}
