//
//  ChattingTalkViewController.swift
//  NoonCam
//
//  Created by 김학철 on 2020/06/17.
//  Copyright © 2020 김학철. All rights reserved.
//

import UIKit
import Toast_Swift

class ChattingTalkViewController: BaseViewController {
    @IBOutlet weak var btnTotal: UIButton!
    @IBOutlet weak var btnVillage: UIButton!
    @IBOutlet weak var btnMyTalk: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    var selectedVc:UIViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imgNor = Utility.image(color: RGBA(80, 150, 180, 1.0))
        let imgSel = Utility.image(color: RGBA(140, 180, 190, 1.0))
        btnTotal.setBackgroundImage(imgNor, for: .normal)
        btnTotal.setBackgroundImage(imgSel, for: .selected)
        
        btnVillage.setBackgroundImage(imgNor, for: .normal)
        btnVillage.setBackgroundImage(imgSel, for: .selected)
        
        let imgNor2 = Utility.image(color: RGBA(160, 64, 54, 1.0))
        let imgSel2 = Utility.image(color: RGBA(210, 115, 105, 1.0))
        btnMyTalk.setBackgroundImage(imgNor2, for: .normal)
        btnMyTalk.setBackgroundImage(imgSel2, for: .selected)
        
        btnTotal.sendActions(for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func onClickedButtonActions(_ sender: UIButton) {
        
        if (sender == btnTotal || sender == btnVillage || sender == btnMyTalk) {
            
            if sender == btnTotal {
                btnTotal.isSelected = false;
                btnVillage.isSelected = false;
                sender.isSelected = true
                if let viewcon = selectedVc {
                    self.myRemoveChildViewController(childViewController: viewcon)
                }
                let chattingTalkVC = self.storyboard?.instantiateViewController(withIdentifier: "ChattingTalkListViewController") as! ChattingTalkListViewController
                chattingTalkVC.listType = .total
                self.myAddChildViewController(superView: containerView, childViewController: chattingTalkVC)
                selectedVc = chattingTalkVC
            }
            else if sender == btnVillage {
                guard let userArea = ShareData.shared.myArea else {
                    self.view.makeToast("지역 설정이 되어 있지 안씁니다.")
                    return
                }
                
                if userArea == "미공개" {
                    self.view.makeToast("지역 비공개 설정입니다.")
                    return
                }
                
                btnTotal.isSelected = false;
                btnVillage.isSelected = false;
                sender.isSelected = true
                
                if let viewcon = selectedVc {
                    self.myRemoveChildViewController(childViewController: viewcon)
                }
                let chattingTalkVC = self.storyboard?.instantiateViewController(withIdentifier: "ChattingTalkListViewController") as! ChattingTalkListViewController
                chattingTalkVC.listType = .village
                self.myAddChildViewController(superView: containerView, childViewController: chattingTalkVC)
                selectedVc = chattingTalkVC
            }
            else if sender == btnMyTalk {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "MytalkViewController") as!MytalkViewController
                vc.type = .chatting
                AppDelegate.instance().getMainMainNavi().pushViewController(vc, animated: false)
            }
        }
    }
}
