
//
//  MoneyRefundViewController.swift
//  NoonCam
//
//  Created by 김학철 on 2020/06/18.
//  Copyright © 2020 김학철. All rights reserved.
//

import UIKit

class MoneyRefundViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnMoneyPicker: UIButton!
    @IBOutlet weak var lbMoneyPicker: UILabel!
    @IBOutlet weak var btnBankPicker: UIButton!
    @IBOutlet weak var lbBankPicker: UILabel!
    
    @IBOutlet weak var tfAccountNumber: UITextField!
    @IBOutlet weak var tfAccountHoldName: UITextField!
    @IBOutlet weak var tfIdFront: UITextField!
    @IBOutlet weak var tfIdBack: UITextField!
    @IBOutlet weak var tfAddress: UITextField!
    @IBOutlet weak var btnOk: UIButton!
    
    @IBOutlet weak var bottomScrollView: NSLayoutConstraint!
    
    var focusTf:[UITextField]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        focusTf = [tfAccountNumber, tfAccountHoldName, tfIdFront, tfIdBack, tfAddress]
        
        btnMoneyPicker.layer.borderWidth = 1.0
        btnMoneyPicker.layer.borderColor = RGB(23, 133, 230).cgColor
        btnMoneyPicker.layer.cornerRadius = 5.0
        btnBankPicker.layer.borderWidth = 1.0
        btnBankPicker.layer.borderColor = RGB(23, 133, 230).cgColor
        btnBankPicker.layer.cornerRadius = 5.0
        
        btnOk.layer.cornerRadius = 5.0
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

    @IBAction func onClickedButtonActions(_ sender: UIButton) {
        if sender == btnBack {
            self.navigationController?.popViewController(animated: false)
        }
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == tfAddress {
            self.view.endEditing(true)
        }
        else {
            var index:Int = (focusTf?.firstIndex(of: textField))!
            index += 1
            let textField:UITextField = focusTf![index]
            textField.becomeFirstResponder()
        }
        return true
    }
    
    //MARK: notificationHandler
    @objc func notificationHandler(_ notification:Notification) {
        let duration = CGFloat((notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.floatValue ?? 0.0)
        let heightKeyboard = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue.size.height
        
        if (notification.name == UIResponder.keyboardWillShowNotification) {
            bottomScrollView.constant = heightKeyboard
            UIView.animate(withDuration: TimeInterval(duration), animations: {
                self.view.layoutIfNeeded()
            })
        } else if (notification.name == UIResponder.keyboardWillHideNotification) {
            bottomScrollView.constant = 0.0
            UIView.animate(withDuration: TimeInterval(duration), animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
}
