//
//  Notice.swift
//  NoonCam
//
//  Created by 김학철 on 2020/06/18.
//  Copyright © 2020 김학철. All rights reserved.
//

import UIKit
import ObjectMapper
class Notice: Mappable {

    var isExpand:Bool = false
    var reg_date: String?
    var view_cnt: Int?
    var user_id: String?
    var use_yn: String?
    var memo: String?
    var page: Int?
    var A_9: Int?
    var title: String?
    var seq: Int?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        reg_date <- map["reg_date"]
        view_cnt <- map["view_cnt"]
        user_id <- map["user_id"]
        use_yn <- map["use_yn"]
        memo <- map["memo"]
        page <- map["page"]
        A_9 <- map["A_9"]
        title <- map["title"]
        seq <- map["seq"]
    }
    
}
