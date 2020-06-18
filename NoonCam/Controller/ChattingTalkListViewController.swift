//
//  ChattingTalkListViewController.swift
//  NoonCam
//
//  Created by 김학철 on 2020/06/17.
//  Copyright © 2020 김학철. All rights reserved.
//

import UIKit
enum ChattingListType : Int {
    case total, village, mytalk
}

class ChattingTalkListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TalkTableViewCellDelegate {
  
    @IBOutlet weak var tblView: UITableView!
    var listType:ChattingListType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblView.register(UINib.init(nibName: "TalkTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "TalkTableViewCell")
        
    }
    
 
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return 10
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          
        let cell: TalkTableViewCell = tableView.dequeueReusableCell(withIdentifier: "TalkTableViewCell") as! TalkTableViewCell
        cell.delegate = self
        if listType == ChattingListType.total {
            cell.type = TalkCellType.total
        }
        else {
            cell.type = TalkCellType.village
        }
        
        cell.configurationData(cellData: ["afjdks":"fdskalfj"])
        return cell
        
      }
      
    //MARK::ChattingTalkCellDelegate
    func chattingTalkCellDidClickedSms(_ sender: UIButton, _ data: NSDictionary, _ action: Int) {
        if (action == 1) {  //sms
            print(action);
        }
        else if (action == 2) { //videocall
            print(action);
        }
    }
}
