//
//  Model.swift
//  NoonCam
//
//  Created by 김학철 on 2020/06/20.
//  Copyright © 2020 김학철. All rights reserved.
//

import UIKit
import ObjectMapper
class CamTalk: Mappable {
    required init?(map: Map) {
        
    }
    var view_cnt: Int?
    var good_cnt: Int?
    var user_name: String?
    var file_name: String?
    var user_age: String?
    var mod_date: Int?
    var cash_date: Int?
    var user_sex: String?
    var times: String?
    var user_id: String?
    var user_area: String?
    var contents: String?
    var img_view: String?
    var days: Int?
    var user_point: Int?
    var seq: Int?
    var status: String?
    
    func mapping(map: Map) {
        view_cnt <- map["view_cnt"]
        good_cnt <- map["good_cnt"]
        user_name <- map["user_name"]
        file_name <- map["file_name"]
        user_age <- map["user_age"]
        mod_date <- map["mod_date"]
        cash_date <- map["cash_date"]
        user_sex <- map["user_sex"]
        times <- map["times"]
        user_id <- map["user_id"]
        user_area <- map["user_area"]
        contents <- map["contents"]
        img_view <- map["img_view"]
        days <- map["days"]
        user_point <- map["user_point"]
        seq <- map["seq"]
        status <- map["status"]
    }
    
    func description() ->String {
        
        var des = ""
        des += "view_cnt : \(String(describing: view_cnt)), "
        des += "good_cnt : \(String(describing: good_cnt)), "
        des += "user_name : \(String(describing: user_name)), "
        des += "file_name : \(String(describing: file_name)), "
        des += "user_age : \(String(describing: user_age)), "
        des += "mod_date : \(String(describing: mod_date)), "
        des += "cash_date : \(String(describing: cash_date)), "
        des += "user_sex : \(String(describing: user_sex)), "
        des += "times : \(String(describing: times)), "
        des += "user_id : \(String(describing: user_id)), "
        des += "user_area : \(String(describing: user_area)), "
        des += "contents : \(String(describing: contents)), "
        des += "img_view : \(String(describing: img_view)), "
        des += "days : \(String(describing: days)), "
        des += "user_point : \(String(describing: user_point)), "
        des += "seq : \(String(describing: seq)), "
        des += "status : \(String(describing: status))"
        return des
    }
}
