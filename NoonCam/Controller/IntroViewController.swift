//
//  IntroViewController.swift
//  NoonCam
//
//  Created by 김학철 on 2020/06/17.
//  Copyright © 2020 김학철. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {

//    @IBOutlet var ivLogo: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(1.5 * Double(NSEC_PER_SEC)) / Double(NSEC_PER_SEC), execute: {
//            self.checkExitMember()
//        })
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.checkExitMember()
    }
    
    func checkExitMember() {
        
        let uuid = Utility.getUUID()
        let param = ["user_id": uuid]
        ApiManager.shared.requestGetUserInfo(param, success: { (result) in
            let isSuccess:NSString = result?["isSuccess"] as! NSString
            if isSuccess == "01" {
                //회원
                
                let userId = result?["user_id"]
                let userSex = result?["user_sex"]
                let userAge = result?["user_age"]
                let userArea = result?["user_area"]
                let userName = result?["user_name"]
                
                ShareData.shared.myId = userId as? String
                if (userSex as! String) == Gender.male.rawValue {
                    ShareData.shared.myGender = .male
                }
                else {
                    ShareData.shared.myGender = .female
                }
                ShareData.shared.myAge = userAge as? String
                ShareData.shared.myArea = userArea as? String
                ShareData.shared.myName = userName as? String
                
                AppDelegate.init().callIntroMainViewController()
            }
            else if isSuccess == "00" {
                //미가입 회원
                AppDelegate.init().callMemberRegistViewController()
            }
            else {
                //탈퇴회원
            }
        }) { (error) in
            print(error)
        }
    }
    
    @objc func viewDidTap() {
        AppDelegate.instance().callIntroMainViewController()
    }
}
