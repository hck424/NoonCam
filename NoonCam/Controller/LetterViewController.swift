//
//  LetterViewController.swift
//  NoonCam
//
//  Created by 김학철 on 2020/06/17.
//  Copyright © 2020 김학철. All rights reserved.
//

import UIKit

class LetterViewController: BaseViewController {
    
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var btnJim: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc : LetterListViewController = self.storyboard?.instantiateViewController(withIdentifier: "LetterListViewController") as! LetterListViewController
        self.myAddChildViewController(superView: containerView, childViewController: vc)
    }
    
    @IBAction func onClickedButtonAction(_ sender: UIButton) {
        
    }   
}
