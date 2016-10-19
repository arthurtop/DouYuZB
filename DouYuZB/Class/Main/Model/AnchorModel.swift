//
//  AnchorModel.swift
//  DouYuZB
//
//  Created by songlei on 2016/10/19.
//  Copyright © 2016年 songlei. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {
    
    var room_id : Int = 0
    
    var vertical_src : String = ""
    
    /// 0 手机直播  1电脑直播
    var isVertical : Int = 0
    
    var room_name : String = ""
    
    var nickname : String = ""
    
    var online : Int = 0
    
    var anchor_city : String = ""
    
    init(dict : [String : NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
}
