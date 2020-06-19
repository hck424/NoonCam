//
//  ItemView.swift
//  NoonCam
//
//  Created by 김학철 on 2020/06/18.
//  Copyright © 2020 김학철. All rights reserved.
//

import UIKit

protocol ItemViewDelegate {
    func didClickedItemView(data:[String:Any])
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
    
    func setData(data:[String:Any], index:Int) {
        ivProfile.layer.cornerRadius = 30
        ivProfile.layer.borderColor = RGB(230, 230, 230).cgColor
        ivProfile.layer.borderWidth = 1.0
        
        lbTitle.text = ""
        if let title = data["title"] {
            lbTitle.text = title as? String
        }
        dataButton.data = data
    }
    
    class func instantiateFromNib() -> ItemView {
        return Bundle.main.loadNibNamed("ItemView", owner: nil, options: nil)!.last as! ItemView
    }
    
    @IBAction func onClickedButtonAction(_ sender: CButton) {
        if (sender.data as? [String:Any]) != nil {
            if let delegate = delegate {
                delegate.didClickedItemView(data: sender.data as! [String : Any])
            }
        }
    }
}
