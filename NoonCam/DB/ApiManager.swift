//
//  ApiManager.swift
//  NoonCam
//
//  Created by 김학철 on 2020/06/19.
//  Copyright © 2020 김학철. All rights reserved.
//

import UIKit

class ApiManager: NSObject {
    static let shared = ApiManager()
    private override init() {}
    
    
    func convertDictToJsonData(_ param:[String : Any]) ->Data? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: param, options: .prettyPrinted)
            let jsonString = String(data: jsonData, encoding: String.Encoding.utf8)
            guard let data = jsonString?.data(using: String.Encoding.utf8) else { return nil}
            return data
        } catch {
            return nil
        }
    }
    
    //MARK: 영상토크 리스트
    func requestCamTalkList(_ params:[String:Any], success: @escaping ResSuccess, failure: @escaping ResFailure) {
        guard let body = self.convertDictToJsonData(params) else { failure(.someError); return }
        
        NetWorkManager.shared.excecutePost("http://snsncam.com/api/talk/imgTalkList.json", body as Data, true, success: { result in
            
            var newResult = result
            if let list = result!["result"]  {
                var newList:[CamTalk] = []
                for item:[String : Any] in list as! [[String : Any]] {
                    let talk = CamTalk(JSON: item, context: nil)
                    if let talk = talk {
                        newList.append(talk)
                    }
//                    print(talk?.description() as Any)
//                    print("\n")
                }
                newResult?["result"] = newList
            }
            
            if let list = result!["hot"]  {
                var newList:[CamTalk] = []
                for item:[String : Any] in list as! [[String : Any]] {
                    let talk = CamTalk(JSON: item, context: nil)
                    if let talk = talk {
                        newList.append(talk)
                    }
                }
                newResult?["hot"] = newList
            }
            print(newResult!)
            success(newResult)
            
        }) { error in
            print(error!)
            failure(error)
        }
    }
    
    //MARK: 메인 톡크 리스트
    func requestChattingTalkList(_ params:[String:Any], success: @escaping ResSuccess, failure: @escaping ResFailure) {
        guard let body = self.convertDictToJsonData(params) else { failure(.someError); return }
        
        NetWorkManager.shared.excecutePost("http://snsncam.com/api/talk/talkList.json", body as Data, true, success: { result in
            
            var newResult = result
            if let list = result!["result"]  {
                var newList:[ChattingTalk] = []
                for item:[String : Any] in list as! [[String : Any]] {
                    let talk = ChattingTalk(JSON: item, context: nil)
                    if let talk = talk {
                        newList.append(talk)
                    }
//                    print(talk?.description() as Any)
//                    print("\n")
                }
                newResult?["result"] = newList
            }
            
            print(newResult!)
            success(newResult)
            
        }) { error in
            print(error!)
            failure(error)
        }
    }
    

    //MARK: 쪽지 리스트
   
    //MARK: 공지 리스트
    func requestNoticeList(_ params:[String:Any], success: @escaping ResSuccess, failure: @escaping ResFailure) {
        guard let body = self.convertDictToJsonData(params) else { failure(.someError); return }
        
        NetWorkManager.shared.excecutePost("http://snsncam.com/api/talk/noticeList.json", body as Data, true, success: { result in
            
            print(result ?? "")
            var newResult = result
            if let list = result!["result"]  {
                var newList:[Notice] = []
                for item:[String : Any] in list as! [[String : Any]] {
                    let notice = Notice(JSON: item, context: nil)
                    if let notice = notice {
                        newList.append(notice)
                    }
                }
                newResult?["result"] = newList
            }
            
            success(newResult)
            
        }) { error in
            print(error!)
            failure(error)
        }
    }
     
    //프로파일 유저 정보 http://snsncam.com/api/talk/getUserInfo.json //"user_id": "{user_id}"
    func requestGetUserInfo(_ params:[String:Any], success: @escaping ResSuccess, failure: @escaping ResFailure) {
        let para = ["clientPara":params]
        guard let body = self.convertDictToJsonData(para) else { failure(.someError); return }
        
        NetWorkManager.shared.excecutePost("http://snsncam.com/api/talk/getUserInfo.json", body as Data, true, success: { result in
            print(result ?? "")
            success(result)
            
        }) { error in
            print(error!)
            failure(error)
        }
    }
        
    
}
