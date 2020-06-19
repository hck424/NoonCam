//
//  ItemView.swift
//  NoonCam
//
//  Created by 김학철 on 2020/06/18.
//  Copyright © 2020 김학철. All rights reserved.
//

import UIKit

class ItemView: UIView {
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbUserId: UILabel!
    @IBOutlet weak var lbAge: UILabel!
    @IBOutlet weak var ivProfile: UIImageView!
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    func setData(data:AnyHashable, index:Int) {
        ivProfile.layer.cornerRadius = 45
        ivProfile.layer.borderColor = RGB(230, 230, 230).cgColor
        ivProfile.layer.borderWidth = 1.0
        lbTitle.text = "\(index)"
    }
    class func instantiateFromNib() -> ItemView {
        return Bundle.main.loadNibNamed("RollingView", owner: nil, options: nil)!.last as! ItemView
    }
    
}
