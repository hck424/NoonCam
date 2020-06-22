//
//  TalkTableViewCell.swift
//  NoonCam
//
//  Created by 김학철 on 2020/06/17.
//  Copyright © 2020 김학철. All rights reserved.
//

import UIKit
import Kingfisher

internal protocol TalkTableViewCellDelegate {
    func chattingTalkCellDidClickedActions(_ sender: UIButton, _ chatting : ChattingTalk, _ action:Int);
    func chattingTalkCellDidShowPhoto(_ sender: UIImageView, imageUrls:[String])
}
enum TalkCellType: String {
    case total = "A"
    case village = "P"
    case jim = "Q" //찜
    case letter = "R" //쪽지
    
    var value: String {
        return self.rawValue
    }
}

class TalkTableViewCell: UITableViewCell {
    @IBOutlet weak var ivThumbnail: UIImageView!
    @IBOutlet weak var lbContent: UILabel!
    @IBOutlet weak var lbUserId: UILabel!
    @IBOutlet weak var lbAge: UILabel!
    @IBOutlet weak var lbGender: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var lbArea: UILabel!
    @IBOutlet weak var btnSms: UIButton!
    @IBOutlet weak var btnVideoCall: UIButton!
    
    var chatting: ChattingTalk?
    var type:TalkCellType!
    
    var delegate: TalkTableViewCellDelegate?
    var imageUrls:[String]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ivThumbnail.isUserInteractionEnabled = true
        let tap:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(showPhoto))
        ivThumbnail.addGestureRecognizer(tap)
        ivThumbnail.layer.cornerRadius = 30;
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configurationData(_ chatting:ChattingTalk) {
        self.chatting = chatting
        lbTime.isHidden = false
        if type == .jim {
            lbTime.isHidden = true
        }
        
        lbContent.text = chatting.title
        lbUserId.text = chatting.user_name!+","
        lbAge.text = chatting.user_age!+","
        lbGender.text = chatting.user_sex
        
        lbArea.text = chatting.user_area!+","
        guard let times = chatting.times else {
            lbTime.text = ""
            return
        }
        
        lbTime.text = self.getTimeString(times)
        
       
        guard let fileName = chatting.file_name, let userId = chatting.user_id else {
            ivThumbnail.isHidden = true
            return
        }
        let urlStr = "http://snsncam.com/upload/talk/\(userId)/thum/crop_\(fileName)"
        guard let url = URL.init(string: urlStr) else {
            ivThumbnail.isHidden = true
            return
        }
        imageUrls = [urlStr]
        
        ivThumbnail.isHidden = false
        let resource = ImageResource(downloadURL: url)
        KingfisherManager.shared.retrieveImage(with: resource) { [weak self] result in
            let image = try? result.get().image
            if let image = image {
                self?.ivThumbnail.image = image
            }
        }
    }
    
    func getTimeString(_ times:String) ->String {
        let arr:[String] = times.components(separatedBy: ":")
        let t:Int = Int.init(arr.first!)!
        let m:Int = Int.init(arr[1])!
        let s:Int = Int.init(arr.last!)!
        
        var result:String = ""
        if t > 0 {
            result += "\(t)시 "
        }
        
        if m > 0 {
            result += "\(m)분 "
        }
        result += "\(s)초 전"
        
        return result
    }
    
    @objc func showPhoto()  {
        if imageUrls?.count == 0 {
            return
        }
        if let delegate = self.delegate {
            delegate.chattingTalkCellDidShowPhoto(ivThumbnail, imageUrls: imageUrls!)
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
                delegate.chattingTalkCellDidClickedActions(sender, chatting!, action)
            }
        }
    }
}

