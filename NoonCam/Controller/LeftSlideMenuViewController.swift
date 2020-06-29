//
//  SlideMenuViewController.swift
//  NoonCam
//
//  Created by 김학철 on 2020/06/16.
//  Copyright © 2020 김학철. All rights reserved.
//

import UIKit
import SideMenu
import Kingfisher
class SideMenuCell: UITableViewCell {
    
    @IBOutlet weak var btnIcon: UIButton!
    @IBOutlet weak var lbTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib();
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        
    }
    public func configurationData(cellData:[String:String]) {
        let title = cellData["title"]
        let imageName = cellData["imgNameNor"]
        
        lbTitle.text = title
        if let imgName = imageName {
            let image = UIImage (named:imgName)
            btnIcon.setImage(image, for: .normal)
        }
    }
}

class LeftSlideMenuViewController: UITableViewController {
    @IBOutlet var headerview: UIView!
    @IBOutlet weak var ivProfile: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbPoint: UILabel!
    @IBOutlet weak var lbSPoint: UILabel!
    @IBOutlet var tblView: UITableView!
    
    var arrData = [["cellId": "profile", "title":"프로필", "imgNameNor":"profile"],
                   ["cellId": "notice", "title":"공지", "imgNameNor":"notice"],
                   ["cellId": "money", "title":"출금", "imgNameNor":"bank"],
                   ["cellId": "setting", "title":"설정", "imgNameNor":"config"]]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        guard let menu = navigationController as? SideMenuNavigationController, menu.blurEffectStyle == nil else {
        //            return
        //        }
        
        ivProfile.layer.cornerRadius = 45
        ivProfile.layer.borderColor = RGB(244, 244, 244).cgColor
        ivProfile.layer.borderWidth = 1.0
        self.tblView.tableHeaderView = headerview
        self.tblView.tableFooterView = UIView()
        self.tblView.estimatedRowHeight = 60
        self.tblView.rowHeight = UITableView.automaticDimension
        self.tblView.separatorColor = .white
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.requestUserInfo()
    }
    
    func requestUserInfo() {
        let param = ["user_id": ShareData.shared.myId]
        ApiManager.shared.requestGetUserInfo(param as [String : Any], success: { reuslt in
            if reuslt != nil {
                ShareData.shared.myInfo = reuslt
                ShareData.shared.myName = reuslt!["user_name"] as? String
                ShareData.shared.myAge = reuslt!["user_age"] as? String
                ShareData.shared.myArea = reuslt!["user_area"] as? String
                self.decorationUi()
            }
        }) { error in
            print(error?.localizedDescription as Any)
        }
    }
    
    func decorationUi() {
        lbName.text = ""
        lbPoint.text = "P:0"
        lbSPoint.text = "S:0"
        ivProfile.image = nil
        
        guard let myInfo = ShareData.shared.myInfo else {
            return
        }
        
        if let gender = myInfo["user_sex"] {
            if gender as! String == "여" {
                ShareData.shared.myGender = .female
            }
            else {
                ShareData.shared.myGender = .male
            }
            
            if ShareData.shared.myGender == .male {
                ivProfile.image = UIImage.init(named: "man")
            }
            else {
                ivProfile.image = UIImage.init(named: "woman")
            }
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
        
        if let name = myInfo["user_name"] {
            lbName.text = name as? String
        }
        
        if let point = myInfo["user_point"] as? String, let i = Int(point) {
            let num = NSNumber.init(value: i)
            let tmp = "P:\(numberString(num))"
            lbPoint.text = tmp
        }
    
        if let inPoint = myInfo["in_user_point"] as? String, let i = Int(inPoint) {
            let num = NSNumber.init(value: i)
            let tmp = "S:\(numberString(num))"
            lbSPoint.text = tmp
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:SideMenuCell = tableView.dequeueReusableCell(withIdentifier: "SideMenuCell") as! SideMenuCell
   
        let item : [String:String] = arrData[indexPath.row]
        cell.configurationData(cellData: item);
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        self.dismiss(animated: true, completion: nil)
        
        let item = arrData[indexPath.row]
        let cellId = item["cellId"]
        
        if cellId == "profile" {
            let vc :ProfileViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
            AppDelegate.instance().getMainMainNavi().pushViewController(vc, animated: false);
        }
        else if cellId == "notice" {
            let vc :NoticeViewController = self.storyboard?.instantiateViewController(withIdentifier: "NoticeViewController") as! NoticeViewController
            AppDelegate.instance().getMainMainNavi().pushViewController(vc, animated: false);
        }
        else if cellId == "money" {
            let vc :MoneyViewController = self.storyboard?.instantiateViewController(withIdentifier: "MoneyViewController") as! MoneyViewController
            AppDelegate.instance().getMainMainNavi().pushViewController(vc, animated: false);
        }
        else if cellId == "setting" {
            let vc :SettingViewController = self.storyboard?.instantiateViewController(withIdentifier: "SettingViewController") as! SettingViewController
            AppDelegate.instance().getMainMainNavi().pushViewController(vc, animated: false);
        }
    }
}

