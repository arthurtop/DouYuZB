//
//  GameViewModel.swift
//  DouYuZB
//
//  Created by songlei on 2016/11/24.
//  Copyright © 2016年 songlei. All rights reserved.
//

import UIKit

class GameViewModel {
    
    lazy var games: [GameModel] = [GameModel]()
    
    
}

extension GameViewModel {
    
    func loadAllGameData(finishedCallback: @escaping() -> ()) {
        AlamoHttpTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: ["shortName":"game"]) {
            (result) in
            
            guard let resultDict = result as? [String : Any] else {return}
            guard let dataArray = resultDict["data"] as? [[String : Any]] else {return}
            
            for dict in dataArray {
                
                self.games.append( GameModel(dict: dict))
            }
            
        }
        
        
    }
    
    
    
}
























