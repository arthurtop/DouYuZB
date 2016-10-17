//
//  PageTitleView.swift
//  DouYuZB
//
//  Created by songlei on 2016/10/10.
//  Copyright © 2016年 songlei. All rights reserved.
//

import UIKit

private let sScrollLineH : CGFloat = 2.0
private let kNormalColor : (CGFloat,CGFloat,CGFloat) = (85,85,85)
private let kSelectColor : (CGFloat,CGFloat,CGFloat) = (255,128,0)


// MARK: -- 定义代理
protocol PageTitleViewDelegate: class {
    
    func pageTitleView(titleView: PageTitleView, index: Int)
    
    
}


class PageTitleView: UIView {
    
    weak var delegate : PageTitleViewDelegate?
    
    fileprivate var currentIndex: Int = 0
    
    fileprivate var titles : [String]
    
    fileprivate var titleLabels : [UILabel] = [UILabel]()
    
    
    
    fileprivate lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.isPagingEnabled = false
        scrollView.bounces = false
        
        return scrollView
    }()
    
    
    fileprivate lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    
    init(frame: CGRect, titles: [String]) {
        self.titles = titles
        
        super.init(frame: frame)
        
        setupUI()
        
    }
    
    ///自定义构造函数 必须重写 下面的方法
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}

// MARK: -- 设置ui界面
extension PageTitleView {
    
    fileprivate func setupUI() {
        
        addSubview(scrollView)
        scrollView.frame = bounds
        
        //添加 title对应的Label
        setupTitleLabels()
        
        
        //设置底线 和 滚动的滑块
        setupBottomLineAndScrollLine()
        
    }
    
    fileprivate func setupTitleLabels() {
        
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - sScrollLineH
        let labelY : CGFloat = 0
        
        for (index, title) in titles.enumerated() {
            let label = UILabel()
            
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            
            
            label.textAlignment = NSTextAlignment.center
            
            
            //设置label的frame
            
            let lableX : CGFloat = labelW * CGFloat(index)
            
            label.frame = CGRect(x: lableX, y: labelY, width: labelW, height: labelH)
            
            
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            //给label 添加手势
            label.isUserInteractionEnabled = true
            
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelCilck(_:)))
            label.addGestureRecognizer(tapGes)
            
        }
    }
    
    fileprivate func setupBottomLineAndScrollLine() {
        
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        
        addSubview(bottomLine)
        
        
        guard let firstLabel = titleLabels.first else {
            return
        }
        
        firstLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        
        scrollView.addSubview(scrollLine)
        
        
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - sScrollLineH, width: firstLabel.frame.width, height: sScrollLineH)
        
        
    }
    
}

// MARK: -- 监听label的点击
extension PageTitleView {
    
    @objc fileprivate func titleLabelCilck(_ tapGes: UIGestureRecognizer) {
        print("----+++")
        //获取label的下标值
        guard let currentLabel = tapGes.view as? UILabel else {return}
        
        //获取之前的 label
        let oldLabel = titleLabels[currentIndex]
        
        currentLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        
        //保存最新label的下标值
        currentIndex = currentLabel.tag
        
        ///使滚动条位置发生改变
        let scrollLineX = CGFloat(currentLabel.tag) * scrollLine.frame.width
        
        UIView.animate(withDuration: 0.15) { 
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        
        //通知代理做事情
        delegate?.pageTitleView(titleView: self, index: currentIndex)
        
    }
    
}

extension PageTitleView {
    
    func setTitleWithProgress(progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        //取出sourceLabel、 targetLabel
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        ///处理滑块的逻辑
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        ///颜色的渐变（较复杂）
        //取出变化范围
        let colorDelta = (kSelectColor.0 - kNormalColor.0,kSelectColor.1 - kNormalColor.1,kSelectColor.2 - kNormalColor.2)
        
        sourceLabel.textColor = UIColor(r: kSelectColor.0 - colorDelta.0 * progress, g: kSelectColor.1 - colorDelta.1 * progress, b: kSelectColor.2 - colorDelta.2 * progress)
        
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        
        //记录最新的index
        currentIndex = targetIndex
    }
}



