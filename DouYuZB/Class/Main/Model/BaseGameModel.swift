//
//  BaseGameModel.swift
//  DouYuZB
//
//  Created by songlei on 2016/11/24.
//  Copyright © 2016年 songlei. All rights reserved.
//

import UIKit

class BaseGameModel: NSObject {
    
    // MARK: -- 定义属性
    var tag_name : String = ""
    var pic_url : String = ""
    
    
    override init() {
        
        
    }
    
    init(dict : [String : Any]) {
        super.init()
        
        setValuesForKeys(dict)
        
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        
    }
    
}
