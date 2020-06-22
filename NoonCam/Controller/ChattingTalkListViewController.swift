//
//  ChattingTalkListViewController.swift
//  NoonCam
//
//  Created by 김학철 on 2020/06/17.
//  Copyright © 2020 김학철. All rights reserved.
//

import UIKit
import Toast_Swift

class ChattingTalkListViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate, TalkTableViewCellDelegate, UIScrollViewDelegate {
    
    
    @IBOutlet weak var tblView: UITableView!
    var listType:ChattingType!
    var pageNum = 1
    var totalPage = 1
    var listData:[ChattingTalk] = []
    var isRequest:Bool = false
    var selChatting:ChattingTalk?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblView.register(UINib.init(nibName: "TalkTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "TalkTableViewCell")
        
        tblView.tableFooterView = UIView.init(frame: CGRect(x: 0, y: 0, width: tblView.frame.size.width, height: 100))
        tblView.estimatedRowHeight = 80
        tblView.rowHeight = UITableView.automaticDimension
        self.requestChattingTalkList()
    }
    
    func requestChattingTalkList() {
        if pageNum > totalPage { return }
        if pageNum == 1 {
            listData.removeAll()
        }
        
        var param: [String: Any] = [:]
        param["user_id"] = (String(describing: ShareData.shared.myId))
        param["pageNum"] = NSNumber(value: pageNum)
        param["my_sex"] = ShareData.shared.myGender.value
        param["search_top"] = "A"
        
        if listType.value == "V" {
            if let memberArea = ShareData.shared.myArea {
                param["search_area"] = memberArea
            }
        }
        
        let para = ["clientPara":param]
        
        isRequest = true
        
        ApiManager.shared.requestChattingTalkList(para, success: { (result) in
            self.isRequest = false
            
            if let list = result?["result"] as? [ChattingTalk] {
                self.listData.append(contentsOf: list)
            }
            
            self.totalPage = result!["bbsCount"] as! Int
            
            self.tblView.reloadData()
            
            self.pageNum += 1
        }, failure: { (error) in
            print(error!)
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: TalkTableViewCell = tableView.dequeueReusableCell(withIdentifier: "TalkTableViewCell") as! TalkTableViewCell
        cell.delegate = self
        
        if listType == ChattingType.total {
            cell.type = .total
        }
        else {
            cell.type = .village
        }
        
        let chatting:ChattingTalk = listData[indexPath.row]
        cell.configurationData(chatting)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    //MARK: UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let velocityY : CGFloat = scrollView.panGestureRecognizer.translation(in: scrollView.superview).y
        let contentOffsetY : CGFloat = scrollView.contentOffset.y + scrollView.frame.size.height
        let contnetSizeH : CGFloat = scrollView.contentSize.height
        
        if velocityY < 0 && contentOffsetY > contnetSizeH && isRequest == false {
            self.requestChattingTalkList()
        }
    }
    
    //MARK:  TalkTableViewCellDelegate
    func chattingTalkCellDidShowPhoto(_ sender: UIImageView, imageUrls: [String]) {
        self.showPhoto(targetView: sender, imageUrls: imageUrls)
    }
    
    
    func chattingTalkCellDidClickedActions(_ sender: UIButton, _ chatting: ChattingTalk, _ action: Int) {
        self.selChatting = chatting
        if (action == 1) {  //sms
            print(action);
        }
        else if (action == 2) { //videocall
            print(action);
            
            guard let talkGender = chatting.user_sex else {
                return
            }
            
            if ShareData.shared.myGender.value == talkGender {
                self.view.makeToast("같은 성별은 영상채팅이 불가능 합니다.!!")
                return
            }
            
            self.showTalkAlertView(chatting)
        }
    }
}
