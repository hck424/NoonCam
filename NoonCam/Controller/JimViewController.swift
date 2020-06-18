//
//  JimViewController.swift
//  NoonCam
//
//  Created by 김학철 on 2020/06/17.
//  Copyright © 2020 김학철. All rights reserved.
//

import UIKit

class JimViewController: UIViewController, TalkTableViewCellDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblView.register(UINib.init(nibName: "TalkTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "TalkTableViewCell")
        
    }
    
    @IBAction func onClickedBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    //MARK:: UItalbeviewDataSource, UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TalkTableViewCell = tableView.dequeueReusableCell(withIdentifier: "TalkTableViewCell") as! TalkTableViewCell
        cell.delegate = self
        cell.type = TalkCellType.jim
        cell.configurationData(cellData: ["afjdks":"fdskalfj"])
        
        return cell
    }
    
    //MARK::TalkTableViewCellDelegate
    func chattingTalkCellDidClickedSms(_ sender: UIButton, _ data: NSDictionary, _ action: Int) {
        if (action == 1) {  //sms
            print(action);
        }
        else if (action == 2) { //videocall
            print(action);
        }
    }
    
}
