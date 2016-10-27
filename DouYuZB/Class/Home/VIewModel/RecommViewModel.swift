//
//  RecommViewModel.swift
//  DouYuZB
//
//  Created by songlei on 2016/10/19.
//  Copyright © 2016年 songlei. All rights reserved.
//

import UIKit
import Alamofire

class RecommViewModel {
    
    // MARK: -- 懒加载属性
    lazy var anchorGroup: [AnchorGroup] = [AnchorGroup]()
    lazy var cycleModels : [CycleModel] = [CycleModel]()
    
    fileprivate lazy var bigDataGroup : AnchorGroup = AnchorGroup()
    fileprivate lazy var prettyGroup : AnchorGroup = AnchorGroup()
    
}


extension RecommViewModel {
    
    ///请求推荐数据
    func requestData(_ finishedCallBack: @escaping () -> ()) {
        
        let parameters = ["limit":"4","offset":"0","time":Date.getCurrentTime()]
        
        
        ///创建group 检测是否所有数据都拿到了
        let dGroup = DispatchGroup()
        
        
        //推荐数据
        dGroup.enter()
        AlamoHttpTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time" : Date.getCurrentTime()]) { (result) in
            guard let resultDic = result as? [String : NSObject] else {return}
            
            guard let dataArray = resultDic["data"] as? [[String : NSObject]] else {return}
            
            
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.bigDataGroup.anchors.append(anchor)
            }
            print("0000")
            dGroup.leave()
        }
        
        
        //颜值数据
        dGroup.enter()
        AlamoHttpTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
            
            guard let resultDic = result as? [String : NSObject] else {return}
            
            guard let dataArray = resultDic["data"] as? [[String : NSObject]] else {return}
            
            
            
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.prettyGroup.anchors.append(anchor)
            }
            print("11111")
            dGroup.leave()
        }
        
        
        
        ///获取游戏数据
        dGroup.enter()
        AlamoHttpTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) { (result) in
            
            guard let resultDic = result as? [String : NSObject] else {return}
            
            guard let dataArray = resultDic["data"] as? [[String : NSObject]] else {return}
            
            
            for dict in dataArray {
                
                let group = AnchorGroup(dict: dict)
                
                self.anchorGroup.append(group)
            }
            print("22222")
            dGroup.leave()
        }
        
        
        ////所有数据都请求到后 排序
        dGroup.notify(queue: DispatchQueue.main) {
            
            self.anchorGroup.insert(self.prettyGroup, at: 0)
            self.anchorGroup.insert(self.bigDataGroup, at: 0)
            
            print("333333")
            finishedCallBack()
            
        }
        
        
        
        
    }
    
    ///请求无线轮播数据
    func requestCycleData(finishCallBack: @escaping ()-> ()) {
        
        AlamoHttpTools.requestData(.get, URLString: "http://www.douyutv.com/api/v1/slide/6", parameters: ["version":"2.300"]) { (result) in
            
            guard let resultDict = result as? [String:NSObject] else {return }
            
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {return }
            
            for dict in dataArray {
                
                self.cycleModels.append(CycleModel(dict: dict))
            }
            
            
            finishCallBack()
            
        }
    }
    
}


