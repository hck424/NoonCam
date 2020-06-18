//
//  LetterViewController.swift
//  NoonCam
//
//  Created by 김학철 on 2020/06/17.
//  Copyright © 2020 김학철. All rights reserved.
//

import UIKit

class LetterViewController: UIViewController {
    
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var btnJim: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc : LetterListViewController = self.storyboard?.instantiateViewController(withIdentifier: "LetterListViewController") as! LetterListViewController
        self.myAddChildVC(childVC: vc)
    }
    
    @IBAction func onClickedButtonAction(_ sender: UIButton) {
        
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
    }
    
    func myRemoveChildVC(childVC:UIViewController) {
        childVC.beginAppearanceTransition(false, animated: true)
        childVC.view.removeFromSuperview()
        childVC.endAppearanceTransition()
    }
    
    
}
