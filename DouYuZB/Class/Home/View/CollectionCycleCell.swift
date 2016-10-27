//
//  CollectionCycleCell.swift
//  DouYuZB
//
//  Created by songlei on 2016/10/21.
//  Copyright © 2016年 songlei. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionCycleCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    
    var cycleModel : CycleModel? {
        
        didSet {
            titleLabel.text = cycleModel?.title
            
            let iconUrl = URL(string: cycleModel?.pic_url ?? "")!
            
            imageView.kf.setImage(with: iconUrl)
        }
        
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
