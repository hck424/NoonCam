//
//  IntroViewController.swift
//  NoonCam
//
//  Created by 김학철 on 2020/06/17.
//  Copyright © 2020 김학철. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {

    @IBOutlet var ivLogo: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewDidTap))
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        ivLogo.addGestureRecognizer(tap)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        AppDelegate.instance().callIntroMainViewController()
    }
    
    @objc func viewDidTap() {
        AppDelegate.instance().callIntroMainViewController()
    }
}
