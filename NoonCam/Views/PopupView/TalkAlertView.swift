//
//  TalkAlertView.swift
//  NoonCam
//
//  Created by 김학철 on 2020/06/18.
//  Copyright © 2020 김학철. All rights reserved.
//

import UIKit

class TalkAlertView: UIView {
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var ivProfile: UIImageView!
    @IBOutlet weak var lbUserId: UIStackView!
    @IBOutlet weak var lbAge: UILabel!
    @IBOutlet weak var lbHartCount: UILabel!
    @IBOutlet weak var lbMessage: UILabel!
    @IBOutlet weak var lbPoint: UILabel!
    @IBOutlet weak var containerview: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ivProfile.layer.cornerRadius = 50.0
        ivProfile.layer.borderColor = RGB(230, 230, 230).cgColor
        ivProfile.layer.borderWidth = 1.0
    }
    
    func setData(data:[String:String]) {
        
    }
    
    class func instantiateFromNib() -> TalkAlertView {
        return Bundle.main.loadNibNamed("TalkAlertView", owner: nil, options: nil)!.first as! TalkAlertView
    }
}
