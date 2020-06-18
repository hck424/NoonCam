//
//  CamTalkViewController.swift
//  NoonCam
//
//  Created by 김학철 on 2020/06/16.
//  Copyright © 2020 김학철. All rights reserved.
//

import UIKit
import QuartzCore

public func RGB(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat) -> UIColor {
    UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
}
public func RGBA(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat) -> UIColor {
    UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a / 1.0)
}


class CamTalkViewController: UIViewController {
    
    
    @IBOutlet var arrTabBtn: [UIButton]!
    
    @IBOutlet weak var containerView: UIView!
    var selectedVc:UIViewController? = nil
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrTabBtn = arrTabBtn.sorted(by: { $0.tag < $1.tag })
        
        for i in 0..<5 {
            let btn = arrTabBtn[i]
            btn.layer.cornerRadius = 5.0
            btn.layer.masksToBounds = true
            btn.addTarget(self, action: #selector(onClickedButtonActions(_:)), for: UIControl.Event.touchUpInside)
            
            if i == 0 || i == 1 || i == 2 {
                let imgNor = Utility.image(color: RGBA(80, 150, 180, 1.0))
                let imgSel = Utility.image(color: RGBA(140, 180, 190, 1.0))
                btn.setBackgroundImage(imgNor, for: .normal)
                btn.setBackgroundImage(imgSel, for: .selected)
            }
            else if i == 3 {
                let imgNor = Utility.image(color: RGBA(204, 150, 74, 1.0))
                let imgSel = Utility.image(color: RGBA(225, 200, 125,1.0))
                btn.setBackgroundImage(imgNor, for: .normal)
                btn.setBackgroundImage(imgSel, for: .selected)
            }
            else {
                let imgNor = Utility.image(color: RGBA(160, 64, 54, 1.0))
                let imgSel = Utility.image(color: RGBA(210, 115, 105, 1.0))
                btn.setBackgroundImage(imgNor, for: .normal)
                btn.setBackgroundImage(imgSel, for: .selected)
            }
        }
        let btn = arrTabBtn.first
        btn?.sendActions(for: UIControl.Event.touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    @IBAction func onClickedButtonActions(_ sender: UIButton) {
        
        if let viewcon = selectedVc {
            self.myRemoveChildVC(childVC: viewcon)
        }
        if sender.tag >= 1 && sender.tag <= 5 {
            for i in 0..<5 {
                let btn = arrTabBtn[i]
                btn.isSelected = false
            }
            sender.isSelected = true
            if sender.tag == 1 {
                let talkListVc = self.storyboard?.instantiateViewController(withIdentifier: "CamTalkListViewController") as! CamTalkListViewController
                talkListVc.listType = ListType.time
                self.myAddChildVC(childVC: talkListVc)
                selectedVc = talkListVc
            }
            else if sender.tag == 2 {
                let talkListVc = self.storyboard?.instantiateViewController(withIdentifier: "CamTalkListViewController") as! CamTalkListViewController
                talkListVc.listType = ListType.popular
                self.myAddChildVC(childVC: talkListVc)
                selectedVc = talkListVc
            }
            else if sender.tag == 3 {
                let talkListVc = self.storyboard?.instantiateViewController(withIdentifier: "CamTalkListViewController") as! CamTalkListViewController
                talkListVc.listType = ListType.regist
                self.myAddChildVC(childVC: talkListVc)
                selectedVc = talkListVc
            }
            else if sender.tag == 4 {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "MytalkViewController") as!MytalkViewController
                vc.type = .camtalk
                AppDelegate.instance().mainNaviController?.pushViewController(vc, animated: false)
            }
            else if sender.tag == 5 {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "JimViewController") as!JimViewController
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
