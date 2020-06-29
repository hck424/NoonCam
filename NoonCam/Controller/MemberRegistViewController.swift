//
//  MemberRegistViewController.swift
//  NoonCam
//
//  Created by 김학철 on 2020/06/23.
//  Copyright © 2020 김학철. All rights reserved.
//

import UIKit

class MemberRegistViewController: UIViewController {
    
    @IBOutlet weak var tfNickName: UITextField!
    @IBOutlet weak var tfUserMemo: UITextField!
    @IBOutlet weak var btnNickNameCheck: UIButton!
    @IBOutlet weak var btnMan: UIButton!
    @IBOutlet weak var btnWoman: UIButton!
    @IBOutlet weak var btnAge: UIButton!
    @IBOutlet weak var lbAge: UILabel!
    @IBOutlet weak var btnArea: UIButton!
    @IBOutlet weak var lbArea: UILabel!
    @IBOutlet weak var btnSound: UIButton!
    @IBOutlet weak var btnShake: UIButton!
    @IBOutlet weak var btnMute: UIButton!
    @IBOutlet weak var btnLinkTerm1: UIButton!
    @IBOutlet weak var btnLinkTerm2: UIButton!
    @IBOutlet weak var btnCheckTerm1: UIButton!
    @IBOutlet weak var btnCheckTerm2: UIButton!
    @IBOutlet weak var tfPartnerCode: UITextField!
    @IBOutlet weak var btnOk: UIButton!
    @IBOutlet weak var bottomScrollView: NSLayoutConstraint!
    @IBOutlet weak var btnBack: UIButton!
    
    var usableNicName = false
    var selAge:String?
    var selArea:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
        
        btnAge.layer.borderWidth = 1.0
        btnAge.layer.borderColor = RGB(230, 230, 230).cgColor
        btnAge.layer.cornerRadius = 5.0
        
        btnArea.layer.borderWidth = 1.0
        btnArea.layer.borderColor = RGB(230, 230, 230).cgColor
        btnArea.layer.cornerRadius = 5.0
        
        
        let attr = NSAttributedString.init(string: (btnLinkTerm1.titleLabel?.text!)!, attributes:[NSAttributedString.Key.underlineStyle : NSNumber(value: NSUnderlineStyle.single.rawValue)])
        btnLinkTerm1 .setAttributedTitle(attr, for: .normal)
        
        let attr2 = NSAttributedString.init(string: (btnLinkTerm2.titleLabel?.text!)!, attributes:[NSAttributedString.Key.underlineStyle : NSNumber(value: NSUnderlineStyle.single.rawValue)])
        btnLinkTerm2 .setAttributedTitle(attr2, for: .normal)
        
        btnSound.isSelected = true
        btnMute.isSelected = true
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(singleTapgesture(_:)))
        self.view.addGestureRecognizer(tap)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    @objc func singleTapgesture(_ sender: UITapGestureRecognizer) {
        if sender.view == self.view {
            self.view.endEditing(true)
        }
    }
    @IBAction func editingChangedActions(_ sender: UITextField) {
        if sender == tfNickName {
            
        }
        
    }
    
    @IBAction func onClickedButtonActions(_ sender: UIButton) {
        self.view.endEditing(true)
        if sender == btnNickNameCheck {
            guard let nickName = tfNickName.text else {
                self.view.makeToast("닉네임을 입력해주세요.")
                return
            }
            
            ApiManager.shared.requestCheckNicName(nickName, successBlock: { (result) in
                let isSuccess = result?["isSuccess"] as! String
                if isSuccess == "00" {
                    self.view.makeToast("사용 가능한 닉네임입니다.")
                    self.usableNicName = true
                }
                else {
                    self.usableNicName = false
                    self.view.makeToast("사용 불가한 닉네입니다.")
                }
            }, failureBlock: { (error) in
                
                print(error!)
            })
        }
        else if sender == btnBack {
            self.navigationController?.popViewController(animated: false)
        }
        else if sender == btnNickNameCheck {
            
        }
        else if sender == btnMan {
            sender.isSelected = !sender.isSelected
            btnWoman.isSelected = !sender.isSelected
        }
        else if sender == btnWoman {
            sender.isSelected = !sender.isSelected
            btnMan.isSelected = !sender.isSelected
        }
        else if sender == btnAge {
            let pickerVC = CPickerViewController.init(nibName: "CPickerViewController", bundle: nil)
            let arr = ["20대", "30대", "40대", "50대", "60대", "70대", "80대"]
            let title = lbAge.text!
            let defaultIndex = arr.firstIndex(of: title) ?? 0
            pickerVC.didSelectedItemWithClosure = (arr, nil,defaultIndex, {(selData:Any?, index:Int) -> () in
                if selData != nil {
                    self.lbAge.text = selData as? String
                    self.selAge = selData as?String
                }
            })
            
            pickerVC.setNeedsStatusBarAppearanceUpdate()
            pickerVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            present(pickerVC, animated: false, completion: nil)

        }
        else if sender == btnArea {
            
            let pickerVC = CPickerViewController.init(nibName: "CPickerViewController", bundle: nil)
            let arr = ["미공개", "서울", "부산", "대구", "인천", "광주", "대전", "울산", "경기", "강원", "충북", "충남", "전북", "전남", "경북", "경남", "제주"]
            let title = lbArea.text!
            let defaultIndex = arr.firstIndex(of: title) ?? 0
            pickerVC.didSelectedItemWithClosure = (arr, nil, defaultIndex, {(selData:Any?, index:Int) -> () in
                if selData != nil {
                    self.lbArea.text = selData as? String
                    self.selArea = selData as?String
                }
            })
            
            pickerVC.setNeedsStatusBarAppearanceUpdate()
            pickerVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            present(pickerVC, animated: false, completion: nil)
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
        else if sender == btnLinkTerm1 {
            let stroyboard:UIStoryboard = UIStoryboard(name: "Intro", bundle: nil)
            let termVC = stroyboard.instantiateViewController(withIdentifier: "TermViewController") as? TermViewController
            termVC?.mode = "yk1"
            termVC?.type = .push
            self.navigationController?.pushViewController(termVC!, animated: false)
            
        }
        else if sender == btnLinkTerm2 {
            let stroyboard:UIStoryboard = UIStoryboard(name: "Intro", bundle: nil)
            let termVC = stroyboard.instantiateViewController(withIdentifier: "TermViewController") as? TermViewController
            termVC?.mode = "yk2"
            termVC?.type = .push
            self.navigationController?.pushViewController(termVC!, animated: false)
        }
        else if sender == btnCheckTerm1 {
            sender.isSelected = !sender.isSelected
        }
        else if sender == btnCheckTerm2 {
            sender.isSelected = !sender.isSelected
        }
        else if sender == btnOk {
            if tfNickName.text?.count == 0 {
                self.view.makeToast("닉네임 필수 정보입니다.")
                return
            }
            
            if tfUserMemo.text?.count == 0 {
                self.view.makeToast("인사말은 필수 정보입니다.")
                return
            }
            
            
            if usableNicName == false {
                self.view.makeToast("닉네임 중복체크를 해주세요.")
                return
            }
            
            if btnMan.isSelected == false && btnWoman.isSelected == false {
                self.view.makeToast("성별을 선택해주세요.")
                return
            }
            
            if selAge == nil {
                self.view.makeToast("연령은 선택해주세요.")
                return
            }
            
            if selArea == nil {
                self.view.makeToast("지역을 선택해주세요.")
                return
            }
            
            if btnCheckTerm1.isSelected == false || btnCheckTerm2.isSelected == false {
                self.view.makeToast("약관을 모두 동의해 주세요.")
                return
            }
            
            
            var param:[String:String] = [:]
            let uuid = Utility.getUUID()
            param["user_id"] = uuid as String
            param["user_name"] = tfNickName.text!
            param["user_memo"] = tfUserMemo.text!
            param["user_age"] = selAge
            param["user_area"] = selArea
            
            var userSex = "여"
            if btnMan.isSelected {
                userSex = "남"
            }

            param["user_sex"] = userSex
            param["user_phone"] = "ios_\(uuid)"
            param["user_mail"] = ""
            param["save_type"] = "G"
            param["app_type"] = "SC"
            param["locale"] = Utility.getLanguage()
            param["version_code"] = Utility.getCurrentVersion()
            
            if btnSound.isSelected && btnShake.isSelected {
                param["noti_yn"] = "A"
            }
            else if btnSound.isSelected {
                param["noti_yn"] = "S"
            }
            else if btnShake.isSelected {
                param["noti_yn"] = "V"
            }
            else {
                param["noti_yn"] = "N"
            }
            
            if let code = tfPartnerCode.text {
                param["parent_id"] = code
            }
            
            ApiManager.shared.requestMemberRegist(param, successBlock: { (result) in
                let isSuccess = result!["isSuccess"] as! String
                if isSuccess == "01" {
                    self.view.makeToast("회원가입이 왼료되었습니다.")
                    ShareData.shared.myId = uuid as String
                    if userSex == "남" {
                        ShareData.shared.myGender = .male
                    }
                    else {
                        ShareData.shared.myGender = .female
                    }
                    UserDefaults.standard.set(uuid, forKey: "MY_ID")
                    UserDefaults.standard.set(userSex, forKey: "MY_SEX")
                    UserDefaults.standard.synchronize()
                    AppDelegate.instance().callIntroMainViewController()
                }
                else {
                    let errorMessage = result?["errorMessage"] as! String
                    self.view.makeToast(errorMessage)
                }
            }) { (error) in
                self.view.makeToast("회원가입이 실패하였습니다.")
                print(error)
            }
            
        }
    }
}
