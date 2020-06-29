//
//  Utility.swift
//  NoonCam
//
//  Created by 김학철 on 2020/06/17.
//  Copyright © 2020 김학철. All rights reserved.
//

import UIKit
import Foundation
import SwiftKeychainWrapper

class Utility : NSObject {

    class func image(color: UIColor) -> UIImage {
        let rect: CGRect = CGRect(x: 0, y: 0, width: 10, height: 10)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    class func getUUID() -> NSString {
        let uniqueServiceName = "NOON_CAM"
//        let uniqueAccessGroup = nil
        let wrapper = KeychainWrapper(serviceName: uniqueServiceName, accessGroup: nil)
        var uuid = wrapper.string(forKey: uniqueServiceName)
        if uuid == nil  {
            let uuidRef = CFUUIDCreate(nil)
            let uuidStringRef = CFUUIDCreateString(nil, uuidRef)
            uuid = uuidStringRef! as String
            let success = wrapper.set(uuid!, forKey: uniqueServiceName)
            print("new uuid create :\(success)")
        }
        
        return uuid! as NSString
    }
    
    class func removeUUID () {
        let uniqueServiceName = "NOON_CAM"
        let wrapper = KeychainWrapper(serviceName: uniqueServiceName, accessGroup: nil)
        wrapper.removeObject(forKey: uniqueServiceName)
    }

    class func getLanguage () -> String {
        let language = NSLocale.preferredLanguages.first
        return language!
    }
    class func getCurrentVersion() -> String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        return version!
    }

}

