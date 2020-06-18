//
//  NoticeDetailView.swift
//  NoonCam
//
//  Created by 김학철 on 2020/06/18.
//  Copyright © 2020 김학철. All rights reserved.
//

import UIKit

class NoticeDetailView: UIView {
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var ivArrow: UIImageView!
    @IBOutlet weak var svDetailContent: UIStackView!
    @IBOutlet weak var tvDetailContent: UITextView!
    @IBOutlet weak var btnExpandCell: UIButton!
    @IBOutlet weak var heightTextView: NSLayoutConstraint!
    
    var notice:Notice?
    
    var  index: Int?
    var isExpand: Bool = false
    
    override class func awakeFromNib() {
        super.awakeFromNib()

    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
    
    func setData(notice: Notice) {
        self.notice = notice
        tvDetailContent.textContainerInset = UIEdgeInsets(top: 8, left: 15, bottom: 15, right: 8)
        tvDetailContent.textContainer.lineBreakMode = .byTruncatingTail

        svDetailContent.isHidden = true
        lbTitle.text = notice.title as String?
        lbDate.text = notice.regiDate as String?
        
    }
    
    @IBAction func onClickedButtonActions(_ sender: Any) {
        notice?.isExpand = !(notice?.isExpand! ?? false)
        if notice?.isExpand! ?? false {
            svDetailContent.isHidden = false
            tvDetailContent.text = notice?.detail! as String?
            let sizeTxt = tvDetailContent.sizeThatFits(CGSize(width: tvDetailContent.frame.size.width, height: 1000))
            heightTextView.constant = sizeTxt.height
            ivArrow.image = UIImage.init(named: "icon_arrow_up")
        }
        else {
            svDetailContent.isHidden = true
            ivArrow.image = UIImage.init(named: "icon_arrow_down")
        }
    }
}
