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
    case GET
    case POST
}

class AlamoHttpTools {
    
    class func requestData(_ type: MethodType, URLString: String, parameters: [String: NSString]? = nil, finishCallback: (_ result: AnyObject)->())  {
        
        let method = type == .GET ? HTTPMethod.get : HTTPMethod.post
        
        //Alamofire.request(URLString, method: method, parameters: parameters, encoding: UTF8, headers: HTTPHeaders?)
        
    }
    
    
}
