//
//  RecommendCycle.swift
//  DouYuTV
//
//  Created by l on 2018/7/27.
//  Copyright © 2018年 l. All rights reserved.
//

import UIKit

class RecommendCycle: UIView {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    private var cycleTimer : Timer?
    private let COLLECTIONCELLID = "CollectionViewCycleCell"
    //定义轮播数据数组
    var anthorModels:[RecommendCycleModel]?{
        didSet{
            //1.刷新collectionView
            collectionView.reloadData()
            //2.设置pageControl
            pageControl.numberOfPages = anthorModels?.count ?? 0
            //3.设置默认滚到中间的某个位置
            let indexPath = NSIndexPath(row: (anthorModels?.count ?? 0) * 10, section: 0)
            collectionView.scrollToItem(at: indexPath as IndexPath, at: .left, animated: false)
            
            //添加定时器先移除
            removeCycleTimer()
            addCycleTimer()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // MARK - 设置此控件不随着我父视图的拉伸而拉伸
        autoresizingMask = [.flexibleBottomMargin,.flexibleLeftMargin,.flexibleRightMargin]
        
        collectionView.register(UINib.init(nibName: "CollectionViewCycleCell", bundle: nil), forCellWithReuseIdentifier: COLLECTIONCELLID)
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //设置collectionView的layoutFlow 布局
        let layoutFlow = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layoutFlow.itemSize = collectionView.bounds.size
        
    }
}


// MARK - 提供一个快捷创建方法
extension RecommendCycle{
    class func recommendCycleView() -> RecommendCycle {
        return Bundle.main.loadNibNamed("RecommendCycle", owner: nil, options: nil)?.first as! RecommendCycle
    }
}
// MARK - 实现UICollectionViewDataSource 代理协议
extension RecommendCycle : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (anthorModels?.count ?? 0)*10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: COLLECTIONCELLID, for: indexPath) as! CollectionViewCycleCell
        let cycleModel = anthorModels![indexPath.item % (anthorModels?.count ?? 0)]
        cell.cycleModel = cycleModel
        return cell
        
    }
}

// MARK - 实现UICollectionViewDelegate

extension RecommendCycle : UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //获取到移动偏移量
        let contentOffx = scrollView.contentOffset.x + scrollView.bounds.size.width*0.5
        //设置pageControl
        pageControl.currentPage = Int((contentOffx/scrollView.bounds.size.width)) % (anthorModels?.count ?? 1)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCycleTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addCycleTimer()
    }
}

// MARK - 对定时器操作
extension RecommendCycle{
    private func addCycleTimer()  {
        //创建timer
        cycleTimer = Timer.init(timeInterval: 3.0, target: self, selector: #selector(scrollToNext), userInfo: nil, repeats: true)
        //添加到runloop
        RunLoop.main.add(cycleTimer!, forMode: RunLoop.Mode.common)
    }
    
    private func removeCycleTimer(){
        cycleTimer?.invalidate() //从runloop运行循环中移除
        cycleTimer = nil
    }
    
    @objc private func scrollToNext(){
        //获取偏移量
        let contentOffsetX = collectionView.contentOffset.x
        let willContentOffx = contentOffsetX + collectionView.bounds.size.width //即将滑动的偏移量
        
        collectionView.setContentOffset(CGPoint(x: willContentOffx, y: 0), animated: true)
        
        
        
    }
}



















