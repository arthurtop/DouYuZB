//
//  Data-Extention.swift
//  DouYuZB
//
//  Created by songlei on 2016/10/19.
//  Copyright © 2016年 songlei. All rights reserved.
//

import Foundation

extension NSDate {
    
    ///获取当前时间
    class func getCurrentTime() -> String {
        
        let nowDate = NSDate()
        let interval = Int(nowDate.timeIntervalSince1970)
        
        return "\(interval)"
    }
    
    
    
}


