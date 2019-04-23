//
//  BaseViewController.swift
//  DouYuTV
//
//  Created by l on 2018/11/15.
//  Copyright © 2018 l. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var contentView : UIView?
    
    fileprivate lazy var loadingImageView : UIImageView = { [unowned self] in
        let loadImageV = UIImageView(image: UIImage(named: "img_loading_1"))
        loadImageV.animationImages = [UIImage(named: "img_loading_1")!,UIImage(named: "img_loading_2")!]
        loadImageV.animationDuration = 0.5
        loadImageV.animationRepeatCount = 0
        loadImageV.center = self.view.center
        loadImageV.autoresizingMask = [.flexibleTopMargin,.flexibleBottomMargin]
        return loadImageV
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}
// MARK:搭建UI界面
extension BaseViewController{
   @objc func setupUI()  {
    //1.设置视图颜色
        view.backgroundColor = UIColor(r: 250, g: 250, b: 250)
    //2.添加loading视图
        view.addSubview(loadingImageView)
    //3.将子类主视图隐藏
        contentView?.isHidden = true
    //4.开始动画
        loadingImageView.startAnimating()
    
    }
}

// MARK:停止动画&显示子视图动画
extension BaseViewController{
    func hiddenLoad()  {
        loadingImageView.stopAnimating()
        loadingImageView.isHidden = true
        contentView?.isHidden = false
    }
}
