//
//  TalkAlertView.swift
//  NoonCam
//
//  Created by 김학철 on 2020/06/18.
//  Copyright © 2020 김학철. All rights reserved.
//

import UIKit
import Kingfisher
import INSPhotoGallery

protocol TalkAlertViewDelegate {
    func showPhoto(targetView:UIImageView, imageUrls:[String])
}
class TalkAlertView: UIView {
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var ivProfile: UIImageView!
    @IBOutlet weak var lbUserName: UILabel!
    @IBOutlet weak var lbAge: UILabel!
    @IBOutlet weak var lbHartCount: UILabel!
    @IBOutlet weak var lbMessage: UILabel!
    @IBOutlet weak var lbPoint: UILabel!
    @IBOutlet weak var containerview: UIView!
    
    var delegate: TalkAlertViewDelegate?
    
    var imageUrls:[String]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ivProfile.layer.cornerRadius = 50.0
        ivProfile.layer.borderColor = RGB(230, 230, 230).cgColor
        ivProfile.layer.borderWidth = 1.0
        ivProfile.isUserInteractionEnabled = true
        let tap:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(didTapShowPhoto))
        ivProfile.addGestureRecognizer(tap)
    }
  
    func setData(_ talk: AnyObject) {
        var userId: NSString?
        var userName: NSString?
        var userAge: NSString?
        var userSex: NSString?
        var content: NSString?
        var fileName: NSString?
        
        var goodCtn: Int = 0
        
        
        if talk is ChattingTalk {
            let tk: ChattingTalk = talk as! ChattingTalk
            userId = tk.user_id as NSString?
            userName = tk.user_name as NSString?
            userAge = tk.user_age as NSString?
            userSex = tk.user_sex as NSString?
            fileName = tk.file_name as NSString?
            content = tk.title as NSString?
            if  tk.good_cnt == nil {
                goodCtn = 0
            }
            else {
               goodCtn = tk.good_cnt! as Int
            }
        }
        else if talk is CamTalk {
            let tk: CamTalk = talk as! CamTalk
            userId = tk.user_id as NSString?
            userName = tk.user_name as NSString?
            userAge = tk.user_age as NSString?
            userSex = tk.user_sex as NSString?
            fileName = tk.file_name as NSString?
            content = tk.contents as NSString?
            if  tk.good_cnt == nil {
                goodCtn = 0
            }
            else {
                goodCtn = tk.good_cnt! as Int
            }
        }
        
        lbUserName.text = userName! as String+","
        lbAge.text = userAge! as String
        let gooCntStr: String = numberString(NSNumber.init(value: goodCtn))
        lbHartCount.text = gooCntStr
        lbMessage.text = content! as String
    
        
        if userSex! == "여" {
            ivProfile.image = UIImage.init(named: "woman")
        }
        else {
            ivProfile.image = UIImage.init(named: "man")
        }
        
        guard let _ = userId, let _ = fileName else {
            return
        }
        
        let urlStr = "http://snsncam.com/upload/talk/\(userId!)/thum/crop_\(fileName!)"
        imageUrls = []
        imageUrls?.append(urlStr)
        guard let url = URL.init(string: urlStr) else {
            return
        }
        
        let resource = ImageResource(downloadURL: url)
        KingfisherManager.shared.retrieveImage(with: resource) { [weak self] result in
            let image = try? result.get().image
            if let image = image {
                self?.ivProfile.image = image
            }
        }
    }
    
    @objc func didTapShowPhoto() {
        print("showProfile")
        
        if imageUrls?.count == 0 {
            return
        }
        
        if let delegate = delegate {
            delegate.showPhoto(targetView: ivProfile, imageUrls: imageUrls!)
        }
    }
    
    class func instantiateFromNib() -> TalkAlertView {
        return Bundle.main.loadNibNamed("TalkAlertView", owner: nil, options: nil)!.first as! TalkAlertView
    }
}
