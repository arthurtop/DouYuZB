//
//  CollectionNormalCell.swift
//  DouYuZB
//
//  Created by songlei on 2016/10/14.
//  Copyright © 2016年 songlei. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionNormalCell: CollectionBaseCell {

    
    @IBOutlet weak var roomNameLabel: UILabel!
    
    
    override var anchor : AnchorModel? {
        didSet {
            
            super.anchor = anchor
            
            
            roomNameLabel.text = anchor?.room_name
            
        }
        
        
    }
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
