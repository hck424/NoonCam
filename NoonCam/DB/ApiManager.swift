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
    
    func convertDictToUrlEncoded(_ param:[String : Any]) -> Data? {
        var str = ""
        var i : Int = 0
        for key in param.keys {
            if i < (param.keys.count - 1) {
                str += "\(key)=\(param[key] as! String)&"
            }
            else {
                str += "\(key)=\(param[key] as! String)"
            }
            i += 1
        }
        
        guard let data = str.data(using: String.Encoding.utf8) else { return nil}
        return data
        
    }
    //이미지 업로드
    func requestUploadImage(userId:String?, image:UIImage?, success: @escaping ResSuccess, failure: @escaping ResFailure) {
        
        guard let userId = userId, let image = image else { failure(.some); return }
        let imageData = image.jpegData(compressionQuality: 1.0)
        let encImgDataStr:String = (imageData?.base64EncodedString(options: []))!
        
        if imageData == nil {
            failure(.some)
            return
        }
        
      
        let param = """
        {user_id": \(userId),
        "user_file": \(encImgDataStr)}
        """

//        let param = ["user_id":userId, "user_file":encImgDataStr]
        
        let body:Data = param.data(using: .utf8, allowLossyConversion: false)!
//        guard let body = self.convertDictToJsonData(param) else {
//        if  body == nil {
//            failure(.encodingJpgDataError)
//            return
//        }
        
        NetWorkManager.shared.excecutePost("http://snsncam.com/api/talk/updateUserTalkImg.do", body, ContentType.formdata, success: { result in
            print(result ?? "")
            success(result)
        }) { error in
            print(error!)
            failure(error)
        }
    }
    
    //MARK: 영상토크 리스트
    func requestCamTalkList(_ params:[String:Any], success: @escaping ResSuccess, failure: @escaping ResFailure) {
        guard let body = self.convertDictToJsonData(params) else { failure(.some); return }
        
        NetWorkManager.shared.excecutePost("http://snsncam.com/api/talk/imgTalkList.json", body as Data, ContentType.json, success: { result in
            
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
        guard let body = self.convertDictToJsonData(params) else { failure(.some); return }
        
        NetWorkManager.shared.excecutePost("http://snsncam.com/api/talk/talkList.json", body as Data, ContentType.json, success: { result in
            
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
        guard let body = self.convertDictToJsonData(params) else { failure(.some); return }
        
        NetWorkManager.shared.excecutePost("http://snsncam.com/api/talk/noticeList.json", body as Data, ContentType.json, success: { result in
            
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
        guard let body = self.convertDictToJsonData(para) else { failure(.some); return }
        
        NetWorkManager.shared.excecutePost("http://snsncam.com/api/talk/getUserInfo.json", body as Data, ContentType.json, success: { result in
            print(result ?? "")
            success(result)
            
        }) { error in
            print(error!)
            failure(error)
        }
    }
        
    //프로파일 정보 변경
    func requestModifyUserInfomation(_ params:[String : Any], successBlock success:@escaping ResSuccess, failureBlock failure: @escaping ResFailure) {
        
        guard let body = self.convertDictToUrlEncoded(params) else { failure(.some); return}
        
        NetWorkManager.shared.excecutePost("http://snsncam.com/api/talk/updateUser.do", body as Data, ContentType.urlencoded, success: { result in
            print(result ?? "")
            success(result)

        }) { error in
            print(error!)
            failure(error)
        }
    }
    
    //회원가입 닉네임 체크
    func requestCheckNicName(_ nickName:String, successBlock success:@escaping ResSuccess, failureBlock failure: @escaping ResFailure) {
        let param = ["clientPara":["user_name":nickName]]
        
        let data = self.convertDictToJsonData(param)
        guard let body = data else { failure(.some); return}
        
        NetWorkManager.shared.excecutePost("http://snsncam.com/api/talk/getNickCheck.json", body as Data, ContentType.json, success: { result in
            print(result ?? "")
            success(result)
            
        }) { error in
            print(error!)
            failure(error)
        }
    }
    //약관 mode=yk1 가입약관, yk2 개인정보
    func requestTermMode(_ mode:String, successBlock success:@escaping ResSuccess, failureBlock failure: @escaping ResFailure) {
        let param = ["mode":mode]
        
        let data = self.convertDictToUrlEncoded(param)
        guard let body = data else { failure(.some); return}
        
        NetWorkManager.shared.excecutePost("http://snsncam.com/api/talk/yk.do", body as Data, ContentType.urlencoded, success: { result in
            print(result ?? "")
            success(result)
            
        }) { error in
            print(error!)
            failure(error)
        }
    }
    
    //회원가입
    func requestMemberRegist(_ param:[String:Any], successBlock success:@escaping ResSuccess, failureBlock failure: @escaping ResFailure) {
        
        let data = self.convertDictToUrlEncoded(param)
        guard let body = data else { failure(.some); return}
        
        NetWorkManager.shared.excecutePost("http://snsncam.com/api/talk/mbinsertUser.do", body as Data, ContentType.urlencoded, success: { result in
            print(result ?? "")
            success(result)
            
        }) { error in
            print(error!)
            failure(error)
        }
    }
    
}
