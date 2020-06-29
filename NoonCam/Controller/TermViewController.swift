//
//  TermViewController.swift
//  NoonCam
//
//  Created by 김학철 on 2020/06/23.
//  Copyright © 2020 김학철. All rights reserved.
//

import UIKit

enum TermViewType: String {
    case regist = "resit"
    case push = "push"
}

class TermViewController: UIViewController {
    
    var mode:String?
    var type:TermViewType = .regist
    
    @IBOutlet weak var svOk: UIStackView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnOk: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if mode! == "yk1" {
            btnBack.setTitle("가입약관", for: .normal)
        }
        else if mode! == "yk2" {
            btnBack.setTitle("개인정보 동의", for: .normal)
        }
        
        if type == .push {
            svOk.isHidden = true
        }
        
        if let mode = mode  {
            ApiManager.shared.requestTermMode(mode, successBlock: { (result) in
                self.textView.text = result?["yk"]! as? String
            }) { (error) in
                
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationItem.setLeftBarButton(nil, animated: false)
        self.navigationItem.hidesBackButton = true
    }
    
    @IBAction func onClickedButtonActions(_ sender: UIButton) {
        if sender == btnBack {
            self.navigationController?.popViewController(animated: false)
        }
        else {
            let vc = UIStoryboard.init(name: "Intro", bundle: nil).instantiateViewController(withIdentifier: "MemberRegistViewController") as! MemberRegistViewController
            
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
