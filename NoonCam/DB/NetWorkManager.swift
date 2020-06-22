//
//  NetWorkManager.swift
//  NoonCam
//
//  Created by 김학철 on 2020/06/19.
//  Copyright © 2020 김학철. All rights reserved.
//

import UIKit
import Alamofire

typealias ResSuccess = ([String:Any]?) -> Void
typealias ResFailure = (ServiceError?) -> Void

class NetWorkManager: NSObject {
    static let shared = NetWorkManager()
    
    
    private override init() {
        
    }
    
    func excecutePost(_ url:NSString, _ body:Data, _ isContentJson:Bool, success: @escaping ResSuccess, failure: @escaping ResFailure) {
        
        guard let url = URL.init(string: url as String) else {
            failure(.someError)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        if (isContentJson) {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        else {
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        }
        
        request.httpBody = body
        AppDelegate.instance().startIndicator()
        
        AF.request(request).responseJSON { response in
            
            AppDelegate.instance().stopIndicator()
            
            if response.error != nil {
                failure(.someError)
            }
            else if response.value != nil {
                let value : [String:Any] = response.value as! [String : Any]
                
                guard let result = value["Result"] as? [String:Any] else {
                    failure(.someError)
                    return
                }
                guard let isSuccess = result["isSuccess"] as? String, isSuccess == "01" else {
                    failure(.someError)
                    return
                }
                
                success(result as [String : Any])
            }
        }

    }
    
}
 
