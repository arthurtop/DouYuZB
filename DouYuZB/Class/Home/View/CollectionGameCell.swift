//
//  CollectionGameCell.swift
//  DouYuZB
//
//  Created by songlei on 2016/10/26.
//  Copyright © 2016年 songlei. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionGameCell: UICollectionViewCell {
    
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    
    // MARK: -- 定义模型属性
    var group : AnchorGroup?{
        
        didSet {
            titleLabel.text = group?.tag_name
            
            
        }
        
    }
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
