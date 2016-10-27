//
//  CycleModel.swift
//  DouYuZB
//
//  Created by songlei on 2016/10/21.
//  Copyright © 2016年 songlei. All rights reserved.
//

import UIKit

class CycleModel: NSObject {
    
    var title:String = ""
    
    
    var pic_url: String = ""
    
    
    var room:[String:NSObject]?{
        didSet {
            guard let room = room else {return }
            anchor = AnchorModel(dict: room)
        }
    }
    
    
    var  anchor : AnchorModel?
    
    
    init(dict:[String:NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}



