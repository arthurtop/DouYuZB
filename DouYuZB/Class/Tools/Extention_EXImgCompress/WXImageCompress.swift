//
//  WXImageCompress.swift
//  DouYuZB
//
//  Created by songlei on 2017/2/22.
//  Copyright © 2017年 songlei. All rights reserved.
//

import UIKit
import Foundation


public enum WechatCompressType {
    
    case session
    case timeline
    
}

public extension UIImage {
    
    
    // MARK: -- xlz  session image boundary is 800; timeline is 1280
    
    func wxCompress(type: WechatCompressType = .timeline) -> UIImage {
        
        let size = self.wxImageSize(type: type) //编辑图片尺寸
        
        let reImage = resizedImage(size: size)  //缩放图片
        
        let data = UIImageJPEGRepresentation(reImage, 0.5)!
        
        return UIImage.init(data: data)
    }
    
    
    
    // MARK: -- xlz session / timeline
    private func wxImageSize(type: WechatCompressType) -> CGSize {
        var width = self.size.width
        var height = self.size.height
        
        var boundary : CGFloat = 1280
        
        //width , height <= 1280, size remains the same
        guard width > boundary || height > boundary else {
            return CGSize(width: width, height: height)
        }
        
        
        // aspect ratio
        let pencent = max(width, height) / min(width, height)
        
        if pencent <= 2 {
            
            let x = max(width, height) / boundary
            if width > height {
                width = boundary
                height = height / x
                
            }else {
                height = boundary
                width = width / x
            }
            
        }else {
            /// width , height > 1280
            if min(width, height) >= boundary{
                boundary = type == .session ? 800 : 1280
                
                let x = min(width, height) / boundary
                if width < height {
                    width = boundary
                    height = height / x
                    
                }else{
                    height = boundary
                    width = width / x
                    
                }
            }
        }
        
        return CGSize(width: width, height: height)
    }
    
    
    //// size : image size
    private func resizedImage(size: CGSize) -> UIImage {
        
        let newRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        var newImage: UIImage!
        UIGraphicsBeginImageContext(newRect.size)
        
        newImage = UIImage(cgImage: self.cgImage, scale: 1, orientation: self.imageOrientation)
        newImage.draw(in: newRect)
        newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    
    
    
}


