//
//  Date-Extention.swift
//  DouYuZB
//
//  Created by songlei on 2016/10/19.
//  Copyright © 2016年 songlei. All rights reserved.
//

import Foundation

extension Date {
    static func getCurrentTime() -> String {
        let nowDate = Date()
        
        let interval = Int(nowDate.timeIntervalSince1970)
        
        return "\(interval)"
    }
}


