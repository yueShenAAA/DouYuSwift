//
//  MainViewController.swift
//  DouYuTV
//
//  Created by l on 2018/7/8.
//  Copyright © 2018年 l. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addChildVC(storyboradName: "Home")
        addChildVC(storyboradName: "Live")
        addChildVC(storyboradName: "Follow")
        addChildVC(storyboradName: "Profile")
        
    }
    //为了适配iOS8 必须代码添加子控制器 不能时候用“refactor to storyboard”，这个功能是iOS9之后的
    private func addChildVC (storyboradName:String){
        //1.通过storyboard获取控制器
        let childVc = UIStoryboard(name: storyboradName, bundle: nil).instantiateInitialViewController()!//传nil就是mainboundle里面的
        //2.将childVC添加为子控制器
        addChild(childVc)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
