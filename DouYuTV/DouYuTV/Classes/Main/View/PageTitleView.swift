//
//  PageTitleView.swift
//  DouYuTV
//
//  Created by l on 2018/7/9.
//  Copyright © 2018年 l. All rights reserved.
//

import UIKit
// Mark - 写class是表示这个协议只能被类遵守，不写可能被结构体、 枚举类型遵守
protocol PageTitleViewDelegate:class{
    func pageTitleView(titleView:PageTitleView , selectIndex index:Int)
}
// Mark - 定义常量
private let kScrollLineH : CGFloat = 2
private let kNormalColor : (CGFloat,CGFloat,CGFloat) = (85,85,85)
private let kSelectedColor : (CGFloat,CGFloat,CGFloat) = (255,128,0)

// Mark - 定义PageTitleView
class PageTitleView: UIView {
    // Mark - 设置代理属性
    weak var delegate:PageTitleViewDelegate?
    // Mark - 懒加载 通过闭包来创建
    private lazy var titleLabels:[UILabel] = [UILabel]()
    // Mark - label下标
    private var currentIndex : Int = 0
    private lazy var myScrollView:UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        // Mark - 设置不超过区域
        scrollView.bounces = false
        return scrollView
    }()
    
    private lazy var scrollLine:UIView = {
        let lineView : UIView = UIView()
        lineView.backgroundColor = UIColor.orange
        
        return lineView
    }()
    // Mark - 创建属性 数组
    private var titles:[String]
    // Mark - 自定义构造函数
    init(frame: CGRect,titles:[String]) {
        self.titles = titles
        super.init(frame: frame)
        setupUI()
    }
    // Mark - 只要重写系统构造函数就要实现这个方法
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// Mark - 创建UI
extension PageTitleView{
    
    private func setupUI(){
        //1.添加myScrollView
        addSubview(myScrollView)
        myScrollView.frame = bounds
        //2.添加title对应的label
        setTitleLabel()
        //3.设置底线和滚动滑块
        setupBottomMenuAndScrollLine()
    }
    
    private func setTitleLabel(){
        // Mark - 遍历titles数组
        // Mark - 0. 稍微提高一下效率
        let labH : CGFloat = frame.height - kScrollLineH
        let labW : CGFloat = frame.width/CGFloat(titles.count)
        let labY : CGFloat = 0
        for (index,title) in titles.enumerated() {
            // Mark - 1.创建UILabel
            let label:UILabel = UILabel()
            // Mark - 2.设置label属性
            label.font = UIFont.boldSystemFont(ofSize: 16.0)
            label.textAlignment = .center
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            label.text = title
            label.tag = index
            // Mark - 3.设置label的frame
            let labX : CGFloat = CGFloat(index) * labW
            label.frame = CGRect(x: labX, y: labY, width: labW, height: labH)
            // Mark - 4.将label添加到scrollView中
            myScrollView.addSubview(label)
            titleLabels.append(label)
            // Mark - 5.添加label点击事件
            label.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.touchLabelClick(tap:)))
            label.addGestureRecognizer(tap)
            
        }
    }
    private func setupBottomMenuAndScrollLine(){
        let bottomLine : UILabel = UILabel()
        bottomLine.frame = CGRect(x: 0, y: frame.height-0.3, width: frame.width, height: 0.3)
        bottomLine.backgroundColor = UIColor.lightGray
        addSubview(bottomLine)
        // Mark - 添加滑块
        // Mark - 获取到第一个label ： guard 如果 titleLabels.first 没有值就return
        guard let fristLab = titleLabels.first else { return }
        fristLab.textColor = UIColor.orange
        myScrollView.addSubview(scrollLine)
        // Mark - 设置line的frame
        scrollLine.frame = CGRect(x: fristLab.frame.origin.x, y: frame.height - kScrollLineH, width: fristLab.frame.width, height: kScrollLineH)
    }
    
}

// Mark - 监听label点击
extension PageTitleView {
    // Mark - label 点击事件
    @objc private func touchLabelClick(tap:UITapGestureRecognizer){
        //1.获取当前点击的label
       guard let currentLabel = tap.view as? UILabel else {return}
        //2.判断点击的是否是同意个label
        if currentLabel.tag == currentIndex {
            return
        }
        //3.获取之前的label
        let oldLab = titleLabels[currentIndex]
        //4.更新文字的颜色
        currentLabel.textColor = UIColor(r: kSelectedColor.0, g: kSelectedColor.1, b: kSelectedColor.2)
        oldLab.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        //5.保存最新label 的下标
        currentIndex = currentLabel.tag
        //6.设置下标滑块坐标
        let scrollLineX:CGFloat = CGFloat(currentLabel.tag) * scrollLine.frame.size.width
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        //7 .通知代理做事
        delegate?.pageTitleView(titleView: self, selectIndex: currentIndex)
        
    }
}

// Mark - 对外暴露的方法
extension PageTitleView{
    func setTitleWithProgress(progress:CGFloat,sourceIndex:Int,targetIndex:Int)  {
        //1.取出当前的sourceIndex/targetIndex(目标)对应的Label
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        //2.处理滑块逻辑
        let moveTotalX : CGFloat = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let scrollLineX:CGFloat = moveTotalX*progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + scrollLineX
        //3.颜色的渐变
        //3.1 取出颜色变化范围
        let colorChangeRange = (kSelectedColor.0 - kNormalColor.0,kSelectedColor.1 - kNormalColor.1,kSelectedColor.2 - kNormalColor.2,1)
        //3.2 变化sourceLabel
        sourceLabel.textColor = UIColor(r: kSelectedColor.0 - colorChangeRange.0 * progress, g: kSelectedColor.1 - colorChangeRange.1 * progress, b: kSelectedColor.2 - colorChangeRange.2 * progress)
        //3.3 变化targetLabel
        targetLabel.textColor = UIColor(r:kNormalColor.0 + colorChangeRange.0 * progress, g: kNormalColor.1 +  colorChangeRange.1 * progress, b: kNormalColor.2 + colorChangeRange.2 * progress)
        //4.记录最新的index
        currentIndex = targetIndex
    }
}








