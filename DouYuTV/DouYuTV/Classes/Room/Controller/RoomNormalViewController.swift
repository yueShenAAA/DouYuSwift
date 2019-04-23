//
//  RoomNormalViewController.swift
//  DouYuTV
//
//  Created by l on 2018/11/16.
//  Copyright © 2018 l. All rights reserved.
//

import UIKit

class RoomNormalViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.red
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //1.隐藏导航栏
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
