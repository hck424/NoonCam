//
//  ServerManager.swift
//  NoonCam
//
//  Created by 김학철 on 2020/06/19.
//  Copyright © 2020 김학철. All rights reserved.
//

import UIKit


class ServerManager: NSObject {
    
    override init() {
        super.init()
        
    }
    
    class func instance() ->ServerManager {
        return ServerManager()
    }
}
