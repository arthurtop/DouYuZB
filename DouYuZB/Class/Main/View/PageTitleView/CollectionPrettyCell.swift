//
//  CollectionPrettyCell.swift
//  DouYuZB
//
//  Created by songlei on 2016/10/14.
//  Copyright © 2016年 songlei. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionPrettyCell: CollectionBaseCell {

    

    
    @IBOutlet weak var cityBtn: UIButton!
    
    
    
    override var anchor : AnchorModel? {
        didSet {
            
            super.anchor = anchor
            
            cityBtn.setTitle(anchor?.anchor_city, for: .normal)

        }
        
    }
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
