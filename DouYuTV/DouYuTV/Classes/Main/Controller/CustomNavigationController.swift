//
//  CustomNavigationController.swift
//  DouYuTV
//
//  Created by l on 2018/11/16.
//  Copyright © 2018 l. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        /*
            ***** 全屏pop手势 ******
         */
        //1.获取系统的pop手势
        let popGesture = interactivePopGestureRecognizer
        //2.获取系统pop手势的target
            //2.1采用运行时来查看UIGestureRecognizer类的隐藏属性
            var count : UInt32 = 0
            let ivarList = class_copyIvarList(UIGestureRecognizer.self, &count)
            for i in 0..<count {
                let ivar = ivarList![Int(i)]
                let ivarName = ivar_getName(ivar)
                print(String(cString: ivarName!))
            }
            //2.2获取到targets
            guard let targets = popGesture?.value(forKey: "_targets") as? [NSObject] else { return }
            print(targets as Any)
            /* 型，里面每个元素是字典，字典里有两个key如下所见
                Optional(<__NSArrayM 0x6000013cec70>(
                (action=handleNavigationTransition:, target=<_UINavigationInteractiveTransition 0x7fae26c21a60>)
                )
                    )
            */
            //2.3直接取targets第一个元素
            guard let targetDict = targets.first else{ return }
            //2.4取到target
            guard let target = targetDict.value(forKey: "target") else{ return }
        //3.获取pop手势的action
        let action = Selector(("handleNavigationTransition:"))
        //4.创建我们想要的手势
        let panGesture = UIPanGestureRecognizer()
        popGesture?.view?.addGestureRecognizer(panGesture)
        panGesture.addTarget(target, action: action)
        
        
    }
    

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.hidesBottomBarWhenPushed = true
        super.pushViewController(viewController, animated: animated)
    }
}
