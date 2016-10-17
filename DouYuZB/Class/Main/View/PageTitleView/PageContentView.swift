//
//  PageContentView.swift
//  DouYuZB
//
//  Created by songlei on 2016/10/11.
//  Copyright © 2016年 songlei. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate: class {
    
    func pageContentView(_ contentView:PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int)
    
    
}


fileprivate let collectionCellID = "collectCell"

class PageContentView: UIView {
    
    weak var delegate: PageContentViewDelegate?
    fileprivate var isForbidScrollDelegate: Bool = false
    
    fileprivate var childVcs: [UIViewController]
    
    fileprivate weak var parentViewController: UIViewController?
    
    fileprivate var startOffsetX : CGFloat = 0.0
    
    fileprivate lazy var collectionView: UICollectionView = {[weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.scrollsToTop = false
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: collectionCellID)
        
        return collectionView
    }()
    
    ///自定义构造函数
    init(frame: CGRect, childVCs: [UIViewController], parentViewController: UIViewController?) {
        self.childVcs = childVCs
        self.parentViewController = parentViewController
        
        super.init(frame: frame)
        
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PageContentView {
    
    fileprivate func setupUI() {
        
        for childVc in childVcs {
            parentViewController?.addChildViewController(childVc)
        }
        
        
        addSubview(collectionView)
        collectionView.frame = bounds
        
    }
    
}


 extension PageContentView: UICollectionViewDataSource {
 
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
     
        return childVcs.count
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellID, for: indexPath)
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
     
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
     
        return cell
     }
 
 }

// MARK: -- uicollectionDelegate
extension PageContentView: UICollectionViewDelegate{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollDelegate = false
        
        startOffsetX = scrollView.contentOffset.x
        
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("---===----")
        
        if isForbidScrollDelegate {return}
        
        
        //获取需要的数据
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        
        //判断是左滑 还是右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOffsetX > startOffsetX { //左滑
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            
            //计算 sourceIndex
            sourceIndex = Int(currentOffsetX / scrollViewW)
            
            //计算targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            
            ///如果完全划过去
            if currentOffsetX - startOffsetX == scrollViewW  {
                progress = 1
                targetIndex = sourceIndex
            }
            
        }else{  ///右滑
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            
            //计算targetIndex
            targetIndex = Int(currentOffsetX / scrollViewW)
            
            //计算 sourceIndex
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count - 1
            }
            
        }
        
        ///将progress/sourceIndex/targetIndex传递给titleView
        print("progress:\(progress) source:\(sourceIndex) targetIndex:\(targetIndex)")
        
        delegate?.pageContentView(self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        
    }
    
}


// MARK: -- 对外暴露的方法
extension PageContentView {
    func setCurrentIndex(currentIndex: Int) {
        
        isForbidScrollDelegate = true
        
        
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        
        collectionView.setContentOffset(CGPoint.init(x: offsetX, y: 0), animated: true)
        
    }
    
}






