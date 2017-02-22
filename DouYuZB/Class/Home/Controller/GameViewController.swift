//
//  GameViewController.swift
//  DouYuZB
//
//  Created by songlei on 2016/10/28.
//  Copyright © 2016年 songlei. All rights reserved.
//

import UIKit

private let kEdgeMargin : CGFloat = 10
private let kItemW : CGFloat = (kScreenW - 2*kEdgeMargin) / 3
private let kItemH : CGFloat = kItemW * 6 / 5

private let gameCollectCellID : String = "gameCollectCellID"

class GameViewController: UIViewController {
    
    fileprivate lazy var gameVM : GameViewModel = GameViewModel()
    
    fileprivate lazy var collectionView : UICollectionView = { [unowned self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: kEdgeMargin, bottom: 0, right: kEdgeMargin)
        
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: gameCollectCellID)
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadData()
        
        
        
    }
    
    
}


extension GameViewController {
    
    func setupUI() {
        view.backgroundColor = UIColor.red
        view.addSubview(collectionView)
        
        
    }
    
}

extension GameViewController {
    
    fileprivate func loadData() {
        gameVM.loadAllGameData {
            self.collectionView.reloadData()
        }
        
    }
    
    
}


extension GameViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: gameCollectCellID, for: indexPath)
        cell.backgroundColor = UIColor.randomColor()
        let gameModel = gameVM.games[indexPath.item]
        print(gameModel.tag_name)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameVM.games.count
    }
    
    
    
    
}






