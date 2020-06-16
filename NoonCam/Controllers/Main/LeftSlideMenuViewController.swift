//
//  SlideMenuViewController.swift
//  NoonCam
//
//  Created by 김학철 on 2020/06/16.
//  Copyright © 2020 김학철. All rights reserved.
//

import UIKit
import SideMenu
class SideMenuCell: UITableViewCell {
    
    @IBOutlet weak var ivIcon: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib();
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        
    }
    public func configurationData(cellData:[String:String]) {
        let title = cellData["title"]
        let imageName = cellData["imageName"]
    
        lbTitle.text = title
        if let imgName = imageName {
            ivIcon.image = UIImage (named:imgName)
        }
    }
}
class LeftSlideMenuViewController: UITableViewController {
    @IBOutlet var headerview: UIView!
    @IBOutlet var tblView: UITableView!
    var arrData = [["cellId": "profile", "title":"프로필", "imageName":""],
                   ["cellId": "notice", "title":"공지", "imageName":""],
                   ["cellId": "money", "title":"출금", "imageName":""],
                   ["cellId": "setting", "title":"설정", "imageName":""]]
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        guard let menu = navigationController as? SideMenuNavigationController, menu.blurEffectStyle == nil else {
//            return
//        }
     
        self.tblView.tableHeaderView = headerview
        self.tblView.tableFooterView = UIView()
        self.tblView.estimatedRowHeight = 60
        self.tblView.rowHeight = UITableView.automaticDimension
        self.tblView.separatorColor = .white
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
    }
}

