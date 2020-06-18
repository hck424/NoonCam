//
//  ChattingTalkViewController.swift
//  NoonCam
//
//  Created by 김학철 on 2020/06/17.
//  Copyright © 2020 김학철. All rights reserved.
//

import UIKit

class ChattingTalkViewController: UIViewController {
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
    
    
    @IBAction func onClickedButtonActions(_ sender: UIButton) {
        
        if (sender == btnTotal || sender == btnVillage || sender == btnMyTalk) {
            btnTotal.isSelected = false;
            btnVillage.isSelected = false;
            btnMyTalk.isSelected = false;
            
            sender.isSelected = true
            
            if let viewcon = selectedVc {
                self.myRemoveChildVC(childVC: viewcon)
            }
            
            if sender == btnTotal || sender == btnVillage {
                let chattingTalkVC = self.storyboard?.instantiateViewController(withIdentifier: "ChattingTalkListViewController") as! ChattingTalkListViewController
                if (sender == btnTotal) {
                    chattingTalkVC.listType = ChattingListType.total
                }
                else {
                    chattingTalkVC.listType = ChattingListType.village
                }
                self.myAddChildVC(childVC: chattingTalkVC)
                selectedVc = chattingTalkVC
            }
            else if sender == btnMyTalk {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "MytalkViewController") as!MytalkViewController
                vc.type = .chatting
                AppDelegate.instance().mainNaviController?.pushViewController(vc, animated: false)
            }
        }
    }
    
    func myAddChildVC(childVC:UIViewController) {
        addChild(childVC)
        
        childVC.beginAppearanceTransition(true, animated: true)
        if let view = childVC.view {
            containerView.addSubview(view)
        }
        childVC.view.frame = containerView.bounds
        childVC.endAppearanceTransition()
        childVC.didMove(toParent: self)
        //        childVC.view.layer.borderColor = UIColor.red.cgColor
        //        childVC.view.layer.borderWidth = 1.0
    }
    
    func myRemoveChildVC(childVC:UIViewController) {
        childVC.beginAppearanceTransition(false, animated: true)
        childVC.view.removeFromSuperview()
        childVC.endAppearanceTransition()
    }
    
}
