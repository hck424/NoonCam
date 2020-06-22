//
//  LetterListViewController.swift
//  NoonCam
//
//  Created by 김학철 on 2020/06/17.
//  Copyright © 2020 김학철. All rights reserved.
//

import UIKit

class LetterListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TalkTableViewCellDelegate {
    func chattingTalkCellDidShowPhoto(_ sender: UIImageView, imageUrls: [String]) {
        
    }
    
    @IBOutlet weak var tblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.register(UINib.init(nibName: "TalkTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "TalkTableViewCell")
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TalkTableViewCell = tableView.dequeueReusableCell(withIdentifier: "TalkTableViewCell") as! TalkTableViewCell
        cell.delegate = self
        cell.type = TalkCellType.letter
//        cell.configurationData(cellData: ["afjdks":"fdskalfj"])
        
        return cell
    }
    
    //MARK: TalkTableViewCellDelegate
    func chattingTalkCellDidClickedActions(_ sender: UIButton, _ chatting: ChattingTalk, _ action: Int) {
        
    }
    
}
