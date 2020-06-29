//
//  NetWorkManager.swift
//  NoonCam
//
//  Created by 김학철 on 2020/06/19.
//  Copyright © 2020 김학철. All rights reserved.
//

import UIKit
import Alamofire

enum ContentType: String {
    case json = "application/json"
    case formdata = "multipart/form-data"
    case urlencoded = "application/x-www-form-urlencoded"
}
typealias ResSuccess = ([String:Any]?) -> Void
typealias ResFailure = (ServiceError?) -> Void

class NetWorkManager: NSObject {
    static let shared = NetWorkManager()
    
    
    private override init() {
        
    }
    
    func excecutePost(_ url:NSString, _ body:Data, _ contentType:ContentType, success: @escaping ResSuccess, failure: @escaping ResFailure) {
        
        guard let url = URL.init(string: url as String) else {
            failure(.some)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(contentType.rawValue, forHTTPHeaderField: "Content-Type")
        
        request.httpBody = body
        AppDelegate.instance().startIndicator()
        
        AF.request(request).responseJSON { response in
            
            AppDelegate.instance().stopIndicator()
            
            if response.error != nil {
                failure(.some)
                AppDelegate.instance().window?.makeToast("실패! code:\(response.error?.localizedDescription ?? "")")
            }
            else if response.value != nil {
                let value : [String:Any] = response.value as! [String : Any]
                
                guard let result = value["Result"] as? [String:Any] else {
                    failure(.resultDataEmpty)
                    AppDelegate.instance().window?.makeToast("실패! code:\(ServiceError.resultDataEmpty.rawValue)")
                    return
                }
//                guard let isSuccess = result["isSuccess"] as? String, isSuccess == "01" else {
//                    failure(.server)
//                    AppDelegate.instance().window?.makeToast("실패! code:\(ServiceError.server.rawValue)")
//                    return
//                }
                
                success(result as [String : Any])
            }
        }

    }
    
//    func excecutePostParam(_ url:NSString, _ param:[String:Any], _ contentType:ContentType, success: @escaping ResSuccess, failure: @escaping ResFailure) {
//        
//        guard let url = URL.init(string: url as String) else {
//            failure(.some)
//            return
//        }
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue(contentType.rawValue, forHTTPHeaderField: "Content-Type")
//        
//        request.httpBody = 
//        
////        for key in param.keys {
////            if let value:String = param[key] as? String {
////                request.setValue(value, forHTTPHeaderField: key)
////            }
////        }
//        AppDelegate.instance().startIndicator()
//        
//        AF.request(request).responseJSON { response in
//            
//            AppDelegate.instance().stopIndicator()
//            
//            if response.error != nil {
//                failure(.some)
//                AppDelegate.instance().window?.makeToast("실패! code:\(response.error?.localizedDescription ?? "")")
//            }
//            else if response.value != nil {
//                let value : [String:Any] = response.value as! [String : Any]
//                
//                guard let result = value["Result"] as? [String:Any] else {
//                    failure(.resultDataEmpty)
//                    AppDelegate.instance().window?.makeToast("실패! code:\(ServiceError.resultDataEmpty.rawValue)")
//                    return
//                }
//                guard let isSuccess = result["isSuccess"] as? String, isSuccess == "01" else {
//                    failure(.server)
//                    AppDelegate.instance().window?.makeToast("실패! code:\(ServiceError.server.rawValue)")
//                    return
//                }
//                
//                success(result as [String : Any])
//            }
//        }
//        
//    }
//    
}
 
