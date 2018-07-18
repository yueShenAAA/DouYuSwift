//
//  UIBarButtonItem-Extension.swift
//  DouYuTV
//
//  Created by l on 2018/7/9.
//  Copyright © 2018年 l. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    //类函数方法
//    class func createButtonIterm(imageName:String,highImageName:String,size:CGSize) -> UIBarButtonItem{
//        let btn = UIButton()
//        btn.setImage(UIImage(named: imageName), for: .normal)
//        btn.setImage(UIImage(named: highImageName), for: .highlighted)
//        btn.frame = CGRect(origin: CGPoint.zero, size: size)
//        
//        return UIBarButtonItem(customView: btn)
//    }
    //便利构造函数 1.必须convenience开头 2.在便利构造函数中必须调用设计构造函数（self）
    convenience init(imageName:String,highImageName:String = "",size:CGSize = CGSize.zero){
        let btn = UIButton()
       
        btn.setImage(UIImage(named: imageName), for: .normal)
        if highImageName != "" {
            btn.setImage(UIImage(named: highImageName), for: .highlighted)
        }
        
        if size == CGSize.zero {
            btn.sizeToFit()
        }else{
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        
        self.init(customView: btn)
    }
}
