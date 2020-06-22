//
//  CamTalkCell.swift
//  NoonCam
//
//  Created by 김학철 on 2020/06/17.
//  Copyright © 2020 김학철. All rights reserved.
//

import UIKit
import Kingfisher

class CamTalkCell: UICollectionViewCell {
    @IBOutlet weak var ivThumbnail: UIImageView!
    @IBOutlet weak var btnCamTalkStatus: UIButton!
    @IBOutlet weak var btnHartCount: UIButton!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbAge: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse();
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        btnHartCount.layer.cornerRadius = 8.0
        btnHartCount.layer.borderColor = RGB(230, 230, 230).cgColor
        btnHartCount.layer.borderWidth = 1.0
    
//        btnCamTalkStatus.layer.cornerRadius = 11.0
//        btnCamTalkStatus.layer.borderColor = RGB(230, 230, 230).cgColor
//        btnCamTalkStatus.layer.borderWidth = 1.0
        
    }
    
    func configurationData(_ talk:CamTalk) {
        lbName.text = ""
        lbAge.text = ""
        ivThumbnail.image = nil
        btnHartCount.setTitle("", for: .normal)
        btnCamTalkStatus.setTitle("영상채팅가능", for: .normal)
        
        lbName.text = talk.user_name!+","
        lbAge.text = talk.user_age!
        let gooCntStr: String = numberString(NSNumber.init(value: talk.good_cnt!))
        btnHartCount .setTitle(gooCntStr, for: .normal)
//        print(talk.description())
        
        if talk.user_sex == "여" {
            ivThumbnail.image = UIImage.init(named: "woman")
        }
        else {
            ivThumbnail.image = UIImage.init(named: "man")
        }
        
        guard let fileName = talk.file_name, let userId = talk.user_id else {
            return
        }
        
        guard let url = URL(string: "http://snsncam.com/upload/talk/\(userId)/thum/crop_\(fileName)") else {
            return
        }
        
        let resource = ImageResource(downloadURL: url)
        KingfisherManager.shared.retrieveImage(with: resource) { [weak self] result in
            let image = try? result.get().image
            if let image = image {
                self?.ivThumbnail.image = image
            }
        }
    }
}
