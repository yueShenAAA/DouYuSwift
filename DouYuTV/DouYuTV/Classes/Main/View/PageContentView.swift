//
//  PageContentView.swift
//  DouYuTV
//
//  Created by l on 2018/7/13.
//  Copyright © 2018年 l. All rights reserved.
//

import UIKit
protocol PageContentViewDelegate:class {
    func  pageContentView(contentView:PageContentView,progress:CGFloat,sourceIndex:Int,targetIndex:Int)
}

private let collectCellID = "collectCellID"

class PageContentView: UIView {
    // Mark - 创建属性
    
    weak var delegate : PageContentViewDelegate?
    private var isFobidScrollDelegate : Bool = false //是否走scrollDelegate 默认为false
    private var startCurrentOffsetX : CGFloat = 0
    private var childVcs:[UIViewController]
    private weak var parentVc:UIViewController?
    // Mark - 懒加载属性
    private lazy var collectionView:UICollectionView = {[weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)! //self?.bounds.size这是一个可选链，返回值一定是一个可选类型，（保证self有值 ）所以(self?.bounds.size)!进行强制解包
        
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal //横向滚动
        
        let conllectionV = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        conllectionV.bounces = false
        conllectionV.isPagingEnabled = true
        conllectionV.showsHorizontalScrollIndicator = false
        conllectionV.dataSource = self
        conllectionV.delegate = self
        conllectionV.register(UICollectionViewCell.self, forCellWithReuseIdentifier: collectCellID)
        return conllectionV
        
    }()
    init(frame: CGRect,childViewControllers:[UIViewController],parentViewController:UIViewController?) {
        childVcs = childViewControllers
        parentVc = parentViewController
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PageContentView {
    private func setupUI(){
        // Mark - 将所有子控制器加进来
        for vc in childVcs {
            parentVc?.addChild(vc)
        }
        // Mark - 添加一个collectionView,用其cell来存放控制器的view
        addSubview(collectionView)
        collectionView.frame = self.bounds
    }
    
}

// Mark - 遵守UICollectionViewDataSource协议
extension PageContentView:UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Mark - 创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectCellID, for: indexPath)
        // Mark - 设置cell
        let childVC = childVcs[indexPath.item]
        // Mark - 移除view 避免重复添加
        for  view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        childVC.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVC.view)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
}

// Mark - 对外暴露的方法函数
extension PageContentView{
    
    func setCurrentIndex(currentIndex:Int) {
        isFobidScrollDelegate = true
        let movePoint = CGPoint(x:kScreenW * CGFloat(currentIndex), y: collectionView.frame.origin.y)
        collectionView.setContentOffset(movePoint, animated: false)
    }
}

// Mark - 遵守UICollectionViewDelegate协议
extension PageContentView:UICollectionViewDelegate{
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isFobidScrollDelegate = false
        //开始滑动的偏移
        startCurrentOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isFobidScrollDelegate {return}
        // Mark - 1.定义需要的数据
        var progress : CGFloat = 0 //占屏幕宽度比
        var sourceIndex:Int = 0
        var tagetIndex:Int = 0
        
        let currentOffsetX = scrollView.contentOffset.x
        
        
        if startCurrentOffsetX > currentOffsetX {
            //右滑
//            print("右滑",currentOffsetX)
            //1.计算progress
            progress = 1 - (currentOffsetX/scrollView.frame.size.width - floor(currentOffsetX/scrollView.frame.size.width))
            //2.计算targetIndex
            tagetIndex = Int(currentOffsetX/scrollView.frame.size.width)
            //3.计算sourceIndex
            if tagetIndex >= childVcs.count{
                sourceIndex = childVcs.count - 1
            }else{
                sourceIndex = tagetIndex + 1
            }
            
        }else{
            //左滑
//            print("左滑",currentOffsetX)
            //1.计算progress
            progress = currentOffsetX/scrollView.frame.size.width - floor(currentOffsetX/scrollView.frame.size.width)
            //2.计算sourceIndex
            sourceIndex = Int(currentOffsetX/scrollView.frame.size.width)
            //3.计算targetIndex
            if sourceIndex >= childVcs.count-1{
                tagetIndex = sourceIndex - 1
            }else{
                tagetIndex = sourceIndex + 1
            }
            //4.如果完全滑过去的时候
            if currentOffsetX - startCurrentOffsetX == scrollView.frame.size.width{
                progress = 1.0
                tagetIndex = sourceIndex
            }
        }
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: tagetIndex)
//        print("progress:\(progress) sourceIndex:\(sourceIndex) targetIndex:\(tagetIndex)")
        
     }
}






