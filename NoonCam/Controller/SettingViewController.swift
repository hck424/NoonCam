//
//  SettingViewController.swift
//  NoonCam
//
//  Created by 김학철 on 2020/06/17.
//  Copyright © 2020 김학철. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnSound: UIButton!
    @IBOutlet weak var btnShake: UIButton!
    @IBOutlet weak var btnMute: UIButton!
    @IBOutlet weak var btnExit: UIButton!
    @IBOutlet weak var btnPushReset: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnPushReset.layer.cornerRadius = 5.0
        btnExit.layer.cornerRadius = 5.0
        
        let isSoundOn = UserDefaults.standard.bool(forKey: "UserPushSound")
        let isShakeOn = UserDefaults.standard.bool(forKey: "UserPushShake")
        
        if (isSoundOn && isShakeOn) {
            btnSound.isSelected = true
            btnShake.isSelected = true
            btnMute.isSelected = false
        }
        else if isSoundOn {
            btnSound.isSelected = true
            btnMute.isSelected = false
        }
        else if isShakeOn {
            btnShake.isSelected = true
            btnMute.isSelected = false
        }
        else {
            btnSound.isSelected = false
            btnShake.isSelected = false
            btnMute.isSelected = true
        }
    }
    @IBAction func onClickedBackAction(_ sender: UIButton) {
        if sender == btnBack {
            self.navigationController?.popViewController(animated: false)
        }
        else if sender == btnSound {
            sender.isSelected = !(sender.isSelected)
            if sender.isSelected == false && btnShake.isSelected == false {
                btnMute.isSelected = true
            }
            else if sender.isSelected {
                btnMute.isSelected = false
                UserDefaults.standard.set(true, forKey: "UserPushSound")
                UserDefaults.standard.synchronize()
            }
        }
        else if sender == btnShake {
            sender.isSelected = !(sender.isSelected)
            if sender.isSelected == false && btnSound.isSelected == false {
                btnMute.isSelected = true
            }
            else if sender.isSelected {
                btnMute.isSelected = false
                UserDefaults.standard.set(true, forKey: "UserPushShake")
                UserDefaults.standard.synchronize()
            }
        }
        else if sender == btnMute {
            sender.isSelected = !(sender.isSelected)
            btnSound.isSelected = !(sender.isSelected)
            btnShake.isSelected = !(sender.isSelected)
            UserDefaults.standard.set(false, forKey: "UserPushSound")
            UserDefaults.standard.set(false, forKey: "UserPushShake")
            UserDefaults.standard.synchronize()
        }
        else if sender == btnExit {
            
        }
    }
}
