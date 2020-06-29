//
//  ShareData.swift
//  NoonCam
//
//  Created by 김학철 on 2020/06/20.
//  Copyright © 2020 김학철. All rights reserved.
//

import UIKit
enum MemberSatus: String {
    case notOpen = "Not_Regist_Member"
    case already = "Already_User_Member"
}
enum Gender: String {
    case male = "남"
    case female = "여"
    
    func opposit() -> Gender {
        switch self {
        case .male:
            return .female
        case .female:
            return .male
        }
    }
    
    var value: String {
        return self.rawValue
    }
}
//영상토크 타입
enum CamTalkType : String {
    case time = "T"
    case popular = "P"
    case regist = "R"
    case all = "A"
    
    var value: String {
        return self.rawValue
    }
}

//토크 타입
enum ChattingType : String {
    case total = "A"
    case village = "V"
    case mytalk = "M"
    
    var value:String {
        return self.rawValue
    }
}
public func numberString(_ num: NSNumber) -> String {

    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.locale = NSLocale(localeIdentifier: "en_US") as Locale
    
    guard let result = formatter.string(from: num) else {
        return "0"
    }
    return result
}


class ShareData: NSObject {
    public var myGender:Gender = .male
    public var myId:String?
    public var myName:String?
    public var myAge:String?
    public var myArea:String?
    public var memberStatus: String?
    var myInfo:[String : Any]?
    
    static let shared = ShareData()
    private override init() {}
    
}
