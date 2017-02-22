//
//  AnchorGroup.swift
//  DouYuZB
//
//  Created by songlei on 2016/10/19.
//  Copyright © 2016年 songlei. All rights reserved.
//

import UIKit

class AnchorGroup: BaseGameModel {
    
    var room_list: [[String : NSObject]]? {
        
        didSet {
            guard let room_list = room_list else {return}
            
            for dict in room_list {
                
                anchors.append(AnchorModel(dict: dict))
            }
            
        }
        
    }
    
    
    var icon_name : String = "home_header_normal"
    
    
    lazy var anchors : [AnchorModel] = [AnchorModel]()
    
    
    
    
   
    
    /*  ////不使用 didSet 可以使用这个方法添加
     override func setValue(_ value: Any?, forKey key: String) {
     if key == "room_list"{
     if let dataArray = value as? [[String : NSObject]] {
     for dict in dataArray {
     anchors.append(AnchorModel(dict: dict))
     }
     }
     }
     }
     */
    
    
    
    
}
