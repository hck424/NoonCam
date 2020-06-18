//
//  TalkTableViewCell.swift
//  NoonCam
//
//  Created by 김학철 on 2020/06/17.
//  Copyright © 2020 김학철. All rights reserved.
//

import UIKit

internal protocol TalkTableViewCellDelegate {
    func chattingTalkCellDidClickedSms(_ sender: UIButton, _ data : NSDictionary, _ action:Int);
}
enum TalkCellType: Int {
    case total, village, jim, letter
}

class TalkTableViewCell: UITableViewCell {
    @IBOutlet weak var ivThumbnail: UIImageView!
    @IBOutlet weak var lbContent: UILabel!
    @IBOutlet weak var lbUserId: UILabel!
    @IBOutlet weak var lbAge: UILabel!
    @IBOutlet weak var lbGender: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var btnSms: UIButton!
    @IBOutlet weak var btnVideoCall: UIButton!
    var data: [String:String]?
    var type:TalkCellType!
    
    var delegate: TalkTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        ivThumbnail.layer.cornerRadius = 30;
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configurationData(cellData:[String:String]) {
        data = cellData
        
        lbTime.isHidden = false
        if type == .jim {
            lbTime.isHidden = true
        }
    }
    
    @IBAction func onClickedButtonAcgtions(_ sender: UIButton) {
        var action:Int = -1
        if sender == btnSms {
            action = 1
        }
        else if sender == btnVideoCall {
            action = 2
        }
        
        if (action > 0) {
            if let delegate = delegate {
                delegate.chattingTalkCellDidClickedSms(sender, ["data" :"1"] as NSDictionary, action)
            }
        }
    }
}

