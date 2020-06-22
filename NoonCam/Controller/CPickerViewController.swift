//
//  CPickerViewController.swift
//  NoonCam
//
//  Created by 김학철 on 2020/06/21.
//  Copyright © 2020 김학철. All rights reserved.
//

import UIKit


class CPickerViewController: UIViewController {
    
    @IBOutlet weak var btnFullClose: UIButton!
    @IBOutlet weak var btnOk: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!
    var arrData:[Any]?
    var keys:[String]?
    var selectedData:Any?
    var selIndex:Int = 0
    var didSelectedItemWithClosure:(arrData:[Any]?, keys:[String]?, actionClosure:((_ selData:Any?, _ index:Int) ->()))? {
        didSet {
            arrData = didSelectedItemWithClosure!.arrData
            keys = didSelectedItemWithClosure!.keys
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onClickedButtonActions(_ sender: UIButton) {
        if sender == btnOk {
            self.didSelectedItemWithClosure?.actionClosure(selectedData, selIndex)
        }
        else if sender == btnFullClose {
            self.didSelectedItemWithClosure?.actionClosure(nil, selIndex)
        }
        self.dismiss(animated: false, completion: nil)
    }
    
}

extension CPickerViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrData?.count ?? 0
    }
}

extension CPickerViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return pickerView.frame.width
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var label:UILabel
        if let v = view as? UILabel{
            label = v
        }
        else {
            label = UILabel()
        }
        
        label.textAlignment = .center
        label.font = UIFont(name: "Helvetica", size: 16)
        
        if let data = arrData?[row] as? String {
            label.text = data
        }
        else if let data = arrData?[row] as? NSAttributedString {
            label.attributedText = data
        }
        else if let data = arrData?[row] as? [String:Any] {
            if keys?.count == 0 {
                label.text = ""
            }
            else if keys?.count == 1 {
                if let key = keys?.first, let d = data[key] as? String {
                    label.text = d
                }
            }
            else {
                var text = ""
                for i in 0..<keys!.count {
                    let key = keys![i]
                    
                    if let d = data[key] as? String {
                        text += "\(d) "
                    }
                    else if let d = data[key] as? Int {
                        text += "\(d) "
                    }
                    else if let d = data[key] as? Float {
                        text += "\(d) "
                    }
                }
                
                label.text = text
            }
        }
        
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedData = arrData?[row]
        self.selIndex = row
    }
}
