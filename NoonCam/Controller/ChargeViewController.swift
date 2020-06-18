//
//  ChargeViewController.swift
//  NoonCam
//
//  Created by 김학철 on 2020/06/17.
//  Copyright © 2020 김학철. All rights reserved.
//

import UIKit

class ChargeViewController: UIViewController {

    @IBOutlet weak var lbCurPoint: UILabel!
    
    @IBOutlet var arrPoint: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        arrPoint = arrPoint.sorted(by: { $0.tag < $1.tag })
        
        for btn in arrPoint {
            btn.layer.cornerRadius = 5.0
            btn.addTarget(self, action: #selector(onClickedButtonActions(_:)), for: UIControl.Event.touchUpInside)
        }
    }
    
    @objc func onClickedButtonActions(_ sender: UIButton) {
        
        if sender.tag >= 1 || sender.tag <= 6 {
            print(sender.titleLabel!.text!)
        }
    }
}
