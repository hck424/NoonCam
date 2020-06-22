//
//  ItemView.swift
//  NoonCam
//
//  Created by 김학철 on 2020/06/18.
//  Copyright © 2020 김학철. All rights reserved.
//

import UIKit
import Kingfisher

protocol ItemViewDelegate {
    func didClickedItemView(_ data: CamTalk)
}
class ItemView: UIView {
    
    @IBOutlet weak var dataButton: CButton!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbUserId: UILabel!
    @IBOutlet weak var lbAge: UILabel!
    @IBOutlet weak var ivProfile: UIImageView!
    
    var delegate: ItemViewDelegate?
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(_ talk:CamTalk) {
        ivProfile.layer.cornerRadius = 30
        ivProfile.layer.borderColor = RGB(230, 230, 230).cgColor
        ivProfile.layer.borderWidth = 1.0
        
        lbTitle.text = talk.contents!
        lbUserId.text = talk.user_name!+","
        lbAge.text = talk.user_age
        if talk.user_sex == "여" {
            ivProfile.image = UIImage.init(named: "woman")
        }
        else {
            ivProfile.image = UIImage.init(named: "man")
        }
        
        guard let url = URL(string: "http://snsncam.com/upload/talk/\(talk.user_id!)/thum/crop_\(talk.file_name!)") else {
            return
        }
        
        let resource = ImageResource(downloadURL: url)
        KingfisherManager.shared.retrieveImage(with: resource) { [weak self] result in
            let image = try? result.get().image
            if let image = image {
                self?.ivProfile.image = image
            }
        }
        
        dataButton.data = talk
    }
    
    class func instantiateFromNib() -> ItemView {
        return Bundle.main.loadNibNamed("ItemView", owner: nil, options: nil)!.last as! ItemView
    }
    
    @IBAction func onClickedButtonAction(_ sender: CButton) {
        let talk: CamTalk = (sender.data as! CamTalk)
        delegate?.didClickedItemView(talk)
    }
}
