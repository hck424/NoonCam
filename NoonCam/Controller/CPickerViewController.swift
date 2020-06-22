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
    var selIndex:Int = 0
    var didSelectedItemWithClosure:(arrData:[Any]?, keys:[String]?,selIndex:Int, actionClosure:((_ selData:Any?, _ index:Int) ->()))? {
        didSet {
            arrData = didSelectedItemWithClosure!.arrData
            keys = didSelectedItemWithClosure!.keys
            self.selIndex = didSelectedItemWithClosure!.selIndex
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerView.selectRow(selIndex, inComponent: 0, animated: true)
    }
    
    @IBAction func onClickedButtonActions(_ sender: UIButton) {
        if sender == btnOk {
            let selData = arrData?[selIndex]
            self.didSelectedItemWithClosure?.actionClosure(selData, selIndex)
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
        
        label.text = ""
        
        var text:NSString = ""
        if let data = arrData?[row] as? String {
            text = data as NSString
        }
        else if let data = arrData?[row] as? [String:Any] {
            if keys?.count == 0 {
                
            }
            else if keys?.count == 1 {
                if let key = keys?.first, let d = data[key] as? String {
                    text = d as NSString
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
            }
        }
        
        let attr: NSAttributedString
        
        if selIndex == row {
            attr = NSAttributedString.init(string: text as String, attributes:[NSAttributedString.Key.foregroundColor: UIColor.red])
        } else {
            attr = NSAttributedString.init(string: text as String, attributes:[NSAttributedString.Key.foregroundColor: UIColor.darkText])
        }
        label.attributedText = attr
        
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selIndex = row
        pickerView.reloadAllComponents()
    }
}
