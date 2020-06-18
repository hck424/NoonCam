//
//  TalkCell.swift
//  NoonCam
//
//  Created by 김학철 on 2020/06/17.
//  Copyright © 2020 김학철. All rights reserved.
//

import UIKit

class TalkCell: UICollectionViewCell {
    @IBOutlet weak var ivThumbnail: UIImageView!
    @IBOutlet weak var btnCamTalkStatus: UIButton!
    @IBOutlet weak var btnHartCount: UIButton!
    @IBOutlet weak var lbTitle: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse();
        lbTitle.text = ""
        ivThumbnail.image = nil
        btnHartCount.setTitle("", for: .normal)
        btnCamTalkStatus.setTitle("", for: .normal)
    }
    
    func configurationData(cellData:[String:Any]) {
        
    }
}
