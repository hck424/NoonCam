//
//  MoneyViewController.swift
//  NoonCam
//
//  Created by 김학철 on 2020/06/17.
//  Copyright © 2020 김학철. All rights reserved.
//

import UIKit

class MoneyViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var heightTextView: NSLayoutConstraint!
    
    @IBOutlet weak var btnRefundList: UIButton!
    @IBOutlet weak var btnCheck: UIButton!
    @IBOutlet weak var btnRefundApplication: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layoutIfNeeded()
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        textView.textContainer.lineBreakMode = .byTruncatingTail
        textView.layer.borderColor = RGB(23, 133, 230).cgColor
        textView.layer.borderWidth = 1.0
        
        let sizeTxt = textView.sizeThatFits(CGSize(width: textView.frame.size.width, height: 1000))
        heightTextView.constant = sizeTxt.height
        
        btnCheck.isSelected = true
        
        btnRefundList.layer.cornerRadius = 5.0
        btnRefundApplication.layer.cornerRadius = 5.0
        
        self.view.layoutIfNeeded()
    }
    @IBAction func onClickedBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }

    @IBAction func onClickedButtonActions(_ sender: UIButton) {
        if sender == btnCheck {
            sender.isSelected = !(sender.isSelected)
        }
        
    }
}
