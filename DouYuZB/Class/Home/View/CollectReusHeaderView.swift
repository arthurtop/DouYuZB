//
//  CollectReusHeaderView.swift
//  DouYuZB
//
//  Created by songlei on 2016/10/14.
//  Copyright © 2016年 songlei. All rights reserved.
//

import UIKit

class CollectReusHeaderView: UICollectionReusableView {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var moreButton: UIButton!
    
    var group : AnchorGroup? {
        didSet {
            titleLabel.text = group?.tag_name
            imageView.image = UIImage(named: (group?.icon_name)!)
            
            
        }
    }
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
