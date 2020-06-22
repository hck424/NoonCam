//
//  ProfileViewController.swift
//  NoonCam
//
//  Created by 김학철 on 2020/06/17.
//  Copyright © 2020 김학철. All rights reserved.
//

import UIKit
import Kingfisher
import Toast_Swift

class ProfileViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var ivProfile: UIImageView!
    @IBOutlet weak var btnProfile: UIButton!
    @IBOutlet weak var tfUserId: UITextField!
    @IBOutlet weak var btnGender: UIButton!
    @IBOutlet weak var btnAge: UIButton!
    @IBOutlet weak var btnArea: UIButton!
    @IBOutlet weak var btnTermsRegit: UIButton!
    @IBOutlet weak var btnTermsPersonal: UIButton!
    @IBOutlet weak var btnOk: UIButton!
    @IBOutlet weak var bottomScroll: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let title1 = btnTermsRegit.titleLabel?.text
        let title2 = btnTermsPersonal.titleLabel?.text
        
        let attr = NSAttributedString(string: title1!, attributes: [
            NSAttributedString.Key.underlineStyle: NSNumber(value: NSUnderlineStyle.single.rawValue)
        ])

        let attr2 = NSAttributedString(string: title2!, attributes: [
            NSAttributedString.Key.underlineStyle: NSNumber(value: NSUnderlineStyle.single.rawValue)
        ])
        
        btnTermsRegit.setAttributedTitle(attr, for: .normal)
        btnTermsPersonal.setAttributedTitle(attr2, for: .normal)
        
        ivProfile.layer.cornerRadius = 50.0
        ivProfile.layer.borderColor = RGB(230, 230, 230).cgColor
        ivProfile.layer.borderWidth = 1.0
        
        btnProfile.layer.cornerRadius = 5.0
        
        btnGender.layer.cornerRadius = 5.0
        btnAge.layer.cornerRadius = 5.0
        btnArea.layer.cornerRadius = 5.0
        
        btnGender.layer.borderColor = RGB(230, 230, 230).cgColor
        btnGender.layer.borderWidth = 1.0
        btnAge.layer.borderColor = RGB(230, 230, 230).cgColor
        btnAge.layer.borderWidth = 1.0
        btnArea.layer.borderColor = RGB(230, 230, 230).cgColor
        btnArea.layer.borderWidth = 1.0
        
        self.decorationUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(notificationHandler(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(notificationHandler(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func decorationUI () {
        guard let myInfo = ShareData.shared.myInfo else {
            return
        }
        
        //default setting
        if ShareData.shared.myGender == .male {
            ivProfile.image = UIImage.init(named: "man")
        }
        else {
            ivProfile.image = UIImage.init(named: "woman")
        }
        
        if let fileName = myInfo["user_img"], let userId = myInfo["user_id"]  {
            guard let url = URL(string: "http://snsncam.com/upload/talk/\(userId)/thum/crop_\(fileName)") else {
                return
            }
            
            let resource = ImageResource(downloadURL: url)
            KingfisherManager.shared.retrieveImage(with: resource) { [weak self] result in
                let image = try? result.get().image
                if let image = image {
                    self?.ivProfile.image = image
                }
            }
        }
        
        btnGender.setTitle(ShareData.shared.myGender.value, for: .normal)
        btnAge.setTitle(myInfo["user_age"] as? String, for: .normal)
        btnArea.setTitle(myInfo["user_area"] as? String, for: .normal)
        tfUserId.text = myInfo["user_name"] as? String
    }
    
    @IBAction func onClickedBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    @IBAction func onClickedButtonActions(_ sender: UIButton) {
        self.view.endEditing(true)
        
        if sender == btnProfile {
            
        }
        else if sender == btnGender {
            
        }
        else if sender == btnAge {
            let pickerVC = CPickerViewController.init(nibName: "CPickerViewController", bundle: nil)
            let arr = ["20대", "30대", "40대", "50대", "60대", "70대", "80대"]
            let title = btnAge.titleLabel?.text!
            let defaultIndex = arr.firstIndex(of: title!) ?? 0
            pickerVC.didSelectedItemWithClosure = (arr, nil,defaultIndex, {(selData:Any?, index:Int) -> () in
                if selData != nil {
                    self.btnAge .setTitle(selData as? String, for: .normal)
                }
            })
            
            pickerVC.setNeedsStatusBarAppearanceUpdate()
            pickerVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            present(pickerVC, animated: false, completion: nil)
        }
        else if sender == btnArea {
            
            let pickerVC = CPickerViewController.init(nibName: "CPickerViewController", bundle: nil)
            let arr = ["미공개", "서울", "부산", "대구", "인천", "광주", "대전", "울산", "경기", "강원", "충북", "충남", "전북", "전남", "경북", "경남", "제주"]
            let title = btnArea.titleLabel?.text!
            let defaultIndex = arr.firstIndex(of: title!) ?? 0
            pickerVC.didSelectedItemWithClosure = (arr, nil, defaultIndex, {(selData:Any?, index:Int) -> () in
                if selData != nil {
                    self.btnArea.setTitle(selData as? String, for: .normal)
                }
            })
            
            pickerVC.setNeedsStatusBarAppearanceUpdate()
            pickerVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            present(pickerVC, animated: false, completion: nil)
        }
        else if sender == btnTermsRegit {
            self.view.makeToast("링크 준비중입니다.")
        }
        else if sender == btnTermsPersonal {
            self.view.makeToast("링크 준비중입니다.")
        }
        else if sender == btnOk {
            if tfUserId.text == nil {
                self.view.makeToast("네임은 필수 정보입니다.")
                return
            }
//            user_id={user_id}&user_name={user_name}&user_age={user_age}&user_area={user_area}&user_sex={user_sex}
            let param = ["user_id": ShareData.shared.myInfo!["user_id"],
                         "user_name" : tfUserId.text!,
                         "user_age" : btnAge.titleLabel?.text!,
                         "user_area" : btnArea.titleLabel?.text!,
                         "user_sex": btnGender.titleLabel?.text!]
            
            ApiManager.shared.requestModifyUserInfomation(param as [String : Any], successBlock: { (result) in
                self.view.makeToast("회원 정보가 수정되었습니다.")
                ShareData.shared.myArea = self.btnArea.titleLabel?.text!
                ShareData.shared.myAge = self.btnAge.titleLabel?.text!
                ShareData.shared.myName = self.tfUserId.text!
            }) { (error) in
                print(error?.localizedDescription ?? "")
            }
            
        }
    }
    
    
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
    
    //MARK: notificationHandler
    @objc func notificationHandler(_ notification:Notification) {
        let duration = CGFloat((notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.floatValue ?? 0.0)
        let heightKeyboard = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue.size.height
        
        if (notification.name == UIResponder.keyboardWillShowNotification) {
            bottomScroll.constant = heightKeyboard
            UIView.animate(withDuration: TimeInterval(duration), animations: {
                self.view.layoutIfNeeded()
            })
        } else if (notification.name == UIResponder.keyboardWillHideNotification) {
            bottomScroll.constant = 0.0
            UIView.animate(withDuration: TimeInterval(duration), animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
}
