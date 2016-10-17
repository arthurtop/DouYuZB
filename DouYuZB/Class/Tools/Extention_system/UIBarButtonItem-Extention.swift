//
//  UIBarButtonItem-Extention.swift
//  DouYuZB
//
//  Created by songlei on 2016/10/10.
//  Copyright © 2016年 songlei. All rights reserved.
//

import Foundation
import UIKit

extension UIBarButtonItem {
    
    //扩展uibarbuttonItem 自定义barbutton
    //  类方法的方式
    /*
     class func createItem(imageName:String, hightImageName:String, size:CGSize) -> UIBarButtonItem {
     
     let btn = UIButton()
     btn.setImage(UIImage(named : imageName), for: .normal)
     btn.setImage(UIImage(named : hightImageName), for: .highlighted)
     btn.frame = CGRect(origin: CGPoint.zero, size: size)
     
     return UIBarButtonItem(customView: btn)
     }
     */
    
    //便利构造 1.convenience开头 2.在构造函数中必须调用一个设计的构造函数（用self 调用的）
    convenience init(imageName:String, hightImageName:String = "", size:CGSize = CGSize.zero) {
        
        let btn = UIButton()
        btn.setImage(UIImage(named : imageName), for: .normal)
        if hightImageName != "" {
            btn.setImage(UIImage(named : hightImageName), for: .highlighted)
        }
        
        if size != CGSize.zero {
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }else{
            btn.sizeToFit()
        }
        
        self.init(customView : btn) 
    }
}






