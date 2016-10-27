//
//  RecommendViewController.swift
//  DouYuZB
//
//  Created by songlei on 2016/10/12.
//  Copyright © 2016年 songlei. All rights reserved.
//

import UIKit

fileprivate let kItemMargin: CGFloat = 10
fileprivate let kItemW = (kScreenW - 3*kItemMargin) / 2
fileprivate let kItemH = kItemW * 3 / 4
fileprivate let kItemPrttyH = kItemW * 4 / 3
fileprivate let kHeaderViewH : CGFloat = 50
fileprivate let kCycleViewH = kScreenW * 3 / 8
fileprivate let kGameViewH: CGFloat = 90


fileprivate let kCollectCellID = "collectCell"
fileprivate let kCollectPrttyId = "kCollectPrttyId"
fileprivate let kCollectHeaderID = "headerID"

class RecommendViewController: UIViewController {
    
    // MARK: -- 懒加载属性
    fileprivate lazy var recommVM : RecommViewModel = RecommViewModel()
    
    fileprivate lazy var gameView : RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()
    
    fileprivate lazy var collectView: UICollectionView = {[unowned self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize.init(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = kItemMargin
        
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH )
        layout.sectionInset = UIEdgeInsetsMake(0, kItemMargin, 0, kItemMargin)
        
        let collFrame = CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH-44)
        
        let collectionView = UICollectionView(frame: collFrame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kCollectCellID)
         collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kCollectPrttyId)
        collectionView.register(UINib(nibName: "CollectReusHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kCollectHeaderID)
        
        return collectionView
    }()
    
    fileprivate lazy var cycleView: RecommendCycleView = {
        
        let cycleView = RecommendCycleView.recommendCycleView()
        
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH+kGameViewH), width: kScreenW, height: kCycleViewH)
        
        return cycleView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        setupUI()
        
        collectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        ///发送网络请求
        loadData()
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


// MARK: -- 请求数据
extension RecommendViewController {
    fileprivate func loadData() {
        
        recommVM.requestData { 
            self.collectView.reloadData()
            
            ///将数据传递给gameView
            self.gameView.groups = self.recommVM.anchorGroup
        }
        
        recommVM.requestCycleData {
            self.cycleView.cycleModels = self.recommVM.cycleModels
        }
        
    }
}


extension RecommendViewController {
    fileprivate func setupUI() {
        
        view.addSubview(collectView)
        
        
        collectView.addSubview(cycleView)
        
        collectView.addSubview(gameView)
        
        ///设置collectionView的内边距
        collectView.contentInset = UIEdgeInsets(top: kCycleViewH + kGameViewH, left: 0, bottom: 0, right: 0)
        
        
        
        
    }
    
    
    
}



extension RecommendViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = recommVM.anchorGroup[section]
        return group.anchors.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommVM.anchorGroup.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let group = recommVM.anchorGroup[indexPath.section]
        let anchor = group.anchors[indexPath.item]
        
        
        var cell : CollectionBaseCell!
        
        
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectPrttyId, for: indexPath) as! CollectionPrettyCell
            
        }else{
             cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectCellID, for: indexPath) as! CollectionNormalCell
            
        }
        cell.anchor = anchor
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kCollectHeaderID, for: indexPath) as! CollectReusHeaderView
        
        headerView.group = recommVM.anchorGroup[indexPath.section]
        
        return headerView
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kItemPrttyH)
        }
        
        return CGSize(width: kItemW, height: kItemH)
    }
    
    
}










