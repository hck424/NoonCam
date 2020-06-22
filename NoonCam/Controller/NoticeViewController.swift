//
//  NoticeViewController.swift
//  NoonCam
//
//  Created by 김학철 on 2020/06/17.
//  Copyright © 2020 김학철. All rights reserved.
//

import UIKit

class NoticeViewController: UIViewController {
    @IBOutlet weak var scrollView: UIStackView!
    @IBOutlet weak var svContent: UIStackView!
    
    var arrData:[Notice] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.requestNoticeList()

        
    }
    
    func requestNoticeList() {

        let param = ["clientPara":["pageNum":NSNumber.init(value: 1)]]
        
        ApiManager.shared.requestNoticeList(param, success: { (result) in
            if let list = result?["result"] as? [Notice] {
                self.arrData.append(contentsOf: list)
                self.scrollView.isHidden = false
                self.decorationUI()
            }
            else {
                self.scrollView.isHidden = true
            }
        }) { (error) in
            print(error?.localizedDescription as Any)
        }
    }
    
    func decorationUI() {
        for notice: Notice in arrData {
            let notiView: NoticeDetailView = Bundle.main.loadNibNamed("NoticeDetailView", owner:self, options: nil)?.first as! NoticeDetailView
            notiView.setData(notice: notice)
            svContent.addArrangedSubview(notiView)
        }
    }
    
    @IBAction func onClickedBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }

}
