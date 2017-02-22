//
//  AlamoHttpTools.swift
//  DouYuZB
//
//  Created by songlei on 2016/10/14.
//  Copyright © 2016年 songlei. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case get
    case post
}

class AlamoHttpTools {
    
    class func requestData(_ type: MethodType, URLString: String, parameters: [String: Any]? = nil, finishedCallback: @escaping (_ result: Any)->())  {
        
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON{ (response) in
            
            guard let result = response.result.value else {
                print(response.result.error ?? 0)
                return
            }
            ///返回数据
            finishedCallback(result)
        }
    }
    
    
}
