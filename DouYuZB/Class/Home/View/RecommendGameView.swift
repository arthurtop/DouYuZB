//
//  RecommendGameView.swift
//  DouYuZB
//
//  Created by songlei on 2016/10/26.
//  Copyright © 2016年 songlei. All rights reserved.
//

import UIKit

fileprivate let kGameCellID = "kGameCellID"

class RecommendGameView: UIView {
    
    var groups: [AnchorGroup]?{
        didSet {
            groups?.removeFirst()
            groups?.removeFirst()
            
            
            ///添加更多
            let moreGrop = AnchorGroup()
            moreGrop.tag_name = "更多"
            groups?.append(moreGrop)
            
            
            
            collectionView.reloadData()
            
            
        }
    }
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ///让控件
        autoresizingMask = UIViewAutoresizing()
        
        
        ///注册cell
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        
        
    }
    
    
    
    
}

// MARK: -- datasource
extension RecommendGameView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionGameCell
        cell.group = groups?[indexPath.item]
        
        //cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.red : UIColor.green
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
}

// MARK: -- 提供快速创建的类方法
extension RecommendGameView {
    class func recommendGameView() -> RecommendGameView {
        
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }
    
    
}


