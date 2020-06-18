
//
//  MytalkViewController.swift
//  NoonCam
//
//  Created by 김학철 on 2020/06/17.
//  Copyright © 2020 김학철. All rights reserved.
//

import UIKit
enum MyTalkType: Int {
    case chatting, camtalk
}
class MytalkViewController: UIViewController {

    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var btnRegitst: UIButton!
    
    var type:MyTalkType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnRegitst.layer.cornerRadius = 5.0
        textView.layer.cornerRadius = 8.0
        textView.layer.borderColor = UIColor.darkGray.cgColor
        textView.layer.borderWidth = 1.0
        
        if type == MyTalkType.camtalk {
            btnBack.setTitle("영상 토크 등록", for: .normal)
            btnRegitst.setTitle("영상토크등록", for: .normal)
        }
        else {
            btnBack.setTitle("토크 등록", for: .normal)
            btnRegitst.setTitle("토크등록", for: .normal)
        }
    }

    @IBAction func onClickedBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func onClickedRegistAction(_ sender: Any) {
        
    }
}
