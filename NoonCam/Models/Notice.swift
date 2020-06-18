//
//  Notice.swift
//  NoonCam
//
//  Created by 김학철 on 2020/06/18.
//  Copyright © 2020 김학철. All rights reserved.
//

import UIKit

class Notice: NSObject {
    var isExpand:Bool?
    var title:NSString?
    var detail:NSString?
    var regiDate:NSString?
    
    init(isExpand:Bool, title:NSString, detail:NSString, regiDate:NSString) {
        self.isExpand = isExpand
        self.title = title
        self.detail = detail
        self.regiDate = regiDate
    }
}
