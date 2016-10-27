//
//  RecommendCycleView.swift
//  DouYuZB
//
//  Created by songlei on 2016/10/20.
//  Copyright © 2016年 songlei. All rights reserved.
//

import UIKit

fileprivate let collectCell = "collectCell"


class RecommendCycleView: UIView {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    ////定时器
    var cycleTimer: Timer?
    
    
    
    var cycleModels : [CycleModel]? {
        didSet {
            collectionView.reloadData()
            
            pageControl.numberOfPages = self.cycleModels?.count ?? 0
            
            //默认滚到中间一个位置
            let index =  NSIndexPath(item: (cycleModels?.count ?? 0)*100, section: 0)
            
            collectionView.scrollToItem(at: index as IndexPath, at: .left, animated: false)
            
            
            ///添加定时器
            removeCycleTimer()
            addCycleTimer()
        }
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 设置该控件不随着父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
        
        
        collectionView.register(UINib(nibName: "CollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: collectCell)
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //设置collectionView的layout
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        
        
        
    }

}



// MARK: -- 类方法
extension RecommendCycleView {
    
    class func recommendCycleView() -> RecommendCycleView {
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
    }
}


// MARK: -- collectionView datadelegate
extension RecommendCycleView: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectCell, for: indexPath) as! CollectionCycleCell
        //cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.red : UIColor.green
        
        cell.cycleModel = cycleModels![(indexPath as NSIndexPath).item % cycleModels!.count]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cycleModels?.count ?? 0) * 10000
    }
    
    
}

extension RecommendCycleView: UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        ///获取偏移量
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        
        
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width) % (cycleModels?.count ?? 1)
        
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCycleTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addCycleTimer()
    }
    
}


// MARK: -- 定时器
extension RecommendCycleView{
    
    fileprivate func addCycleTimer() {
        
        cycleTimer = Timer(timeInterval: 2.0, target: self, selector: #selector(self.scrollToNextImg), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: RunLoopMode.commonModes)
        
    }
    
    fileprivate func removeCycleTimer() {
        
        cycleTimer?.invalidate()  ///从运行循环中移除
        cycleTimer = nil
        
    }
    
    @objc fileprivate func scrollToNextImg(){
        ///获取滚到偏移量
        let currentOffsetX = collectionView.contentOffset.x
        let offsetX = currentOffsetX + collectionView.bounds.width
        
        ///滚动该位置
        collectionView.setContentOffset(CGPoint(x:offsetX , y:0), animated: true)
        
        
    }
    
    
}

