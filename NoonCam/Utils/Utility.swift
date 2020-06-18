//
//  Utility.swift
//  NoonCam
//
//  Created by 김학철 on 2020/06/17.
//  Copyright © 2020 김학철. All rights reserved.
//

import UIKit
import Foundation

class Utility : NSObject {
//    class func image(from color: UIColor) -> UIImage {
//
//        let rect = CGRect(x: 0, y: 0, width: 10, height: 10)
//        UIGraphicsBeginImageContext(rect.size)
//        let context = UIGraphicsGetCurrentContext()
//        context?.setFillColor(color.cgColor )
//        context?.fill(rect)
//
//        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return UIImage()}
//        UIGraphicsEndImageContext()
//        return image
//    }
    
    class func image(color: UIColor) -> UIImage {
        let rect: CGRect = CGRect(x: 0, y: 0, width: 10, height: 10)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}

