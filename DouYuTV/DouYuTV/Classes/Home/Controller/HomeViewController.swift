//
//  HomeViewController.swift
//  DouYuTV
//
//  Created by l on 2018/7/8.
//  Copyright © 2018年 l. All rights reserved.
//

import UIKit
private var kTitleViewH : CGFloat = 40

class HomeViewController: UIViewController {
    
    private lazy var pageTitleView : PageTitleView = {[weak self] in
        
        let rect = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles:[String] = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView.init(frame: rect, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    
    private lazy var pageContentView:PageContentView = {[weak self] in
        // Mark - 确定内容的frame
        let pageContentH:CGFloat = kScreenH - (kStatusBarH + kNavigationBarH + kTitleViewH + kTabBarH)
        let frame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: pageContentH)
        
        // Mark - 创建所有子控制器
        var childVcs = [UIViewController]()
        childVcs.append(RecommendViewController())
        childVcs.append(GameViewController())
        childVcs.append(AmuseViewController())
        childVcs.append(FunnyViewController())
        let pageContentV = PageContentView(frame: frame, childViewControllers: childVcs, parentViewController: self)
        pageContentV.delegate = self
        return pageContentV
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
}

extension HomeViewController{
    
    private func setUpUI(){
        // Mark - 不需要调整scrollview的内边距
        automaticallyAdjustsScrollViewInsets = false
        // Mark - 添加导航栏
        setNavigationBar()
        // Mark - 添加TitleView
        view.addSubview(pageTitleView)
        // Mark - 添加PageContentView
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.purple 
    }
    
    private func setNavigationBar(){
        
        let size = CGSize(width: 40, height: 40)
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")

        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        let scanningItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem,searchItem,scanningItem]
        
    }
}

// Mark - 遵守PageTitleViewDelegate
extension HomeViewController: PageTitleViewDelegate {

    func pageTitleView(titleView: PageTitleView, selectIndex index: Int) {
        
        self.pageContentView.setCurrentIndex(currentIndex: index)
    }
}

// Mark - 遵守PageContentViewDelegate
extension HomeViewController: PageContentViewDelegate{
    
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
    
    
}









