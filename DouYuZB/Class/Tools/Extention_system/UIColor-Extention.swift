//
//  UIColor-Extention.swift
//  DouYuZB
//
//  Created by songlei on 2016/10/11.
//  Copyright © 2016年 songlei. All rights reserved.
//

//import Foundation
import UIKit

extension UIColor {
    
    convenience init(r : CGFloat, g : CGFloat, b :CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
    
    convenience init(r : CGFloat, g : CGFloat, b :CGFloat, alpha: CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }
    
    convenience init(R : CGFloat, G : CGFloat, B :CGFloat) {
        self.init(red: R / 255.0, green: G / 255.0, blue: B / 255.0, alpha: 1.0)
    }
    
    
    
    // MARK: -- 随机颜色
    class func randomColor() -> UIColor {
        return UIColor(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)))
    }
    
    
    
    
    
}









