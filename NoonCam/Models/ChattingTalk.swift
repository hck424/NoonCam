//
//  ChattingTalk.swift
//  NoonCam
//
//  Created by 김학철 on 2020/06/20.
//  Copyright © 2020 김학철. All rights reserved.
//

import UIKit
import ObjectMapper
class ChattingTalk:CamTalk {
    var file_name3: String?
    var file_name2: String?
    var title: String?
    var reg_date: String?
    var talk_point: String?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        file_name3 <- map["file_name3"]
        file_name2 <- map["file_name2"]
        title <- map["title"]
        reg_date <- map["reg_date"]
        talk_point <- map["talk_point"]
    }
    
    override func description() -> String {
        
        var des:String = ""
        des = super.description()
        
        des += "file_name3 : \(String(describing: file_name3)), "
        des += "file_name2 : \(String(describing: file_name2)), "
        des += "title : \(String(describing: title)), "
        des += "reg_date : \(String(describing: reg_date)), "
        des += "talk_point : \(String(describing: talk_point)), "
        
        return des
    }
    

}
