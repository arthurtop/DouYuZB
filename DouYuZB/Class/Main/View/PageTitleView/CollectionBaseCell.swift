//
//  CollectionBaseCell.swift
//  DouYuZB
//
//  Created by songlei on 2016/10/20.
//  Copyright © 2016年 songlei. All rights reserved.
//

import UIKit

class CollectionBaseCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nickNameLabel: UILabel!
    
    @IBOutlet weak var onlineBtn: UIButton!
    
    
    var anchor : AnchorModel? {
        
        didSet {
            
            guard let anchor = anchor else {
                return
            }
            
            var onlineStr : String = ""
            
            if anchor.online >= 10000 {
                
                onlineStr = "\(Int(anchor.online / 10000))在线"
                
            }else {
                
                onlineStr = "\(Int(anchor.online))在线"
            }
            
            onlineBtn.setTitle(onlineStr, for: .normal)
            
            nickNameLabel.text = anchor.nickname
            
            guard let url = URL(string: anchor.vertical_src) else {return}
            imageView.kf.setImage(with: url)
            
        }
    }
}
