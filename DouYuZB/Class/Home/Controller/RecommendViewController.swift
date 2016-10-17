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

fileprivate let kCollectCellID = "collectCell"
fileprivate let kCollectPrttyId = "kCollectPrttyId"
fileprivate let kCollectHeaderID = "headerID"

class RecommendViewController: UIViewController {

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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        setupUI()
        
        collectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        
        
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension RecommendViewController {
    fileprivate func setupUI() {
        
        view.addSubview(collectView)
        
        
    }
    
    
}

extension RecommendViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 8
        }
        return 4
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = UICollectionViewCell()
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectPrttyId, for: indexPath)
        }else{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectCellID, for: indexPath)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kCollectHeaderID, for: indexPath)
        
        return headerView
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kItemPrttyH)
        }
        
        return CGSize(width: kItemW, height: kItemH)
    }
    
    
}










