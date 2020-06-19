//
//  CamTalkListViewController.swift
//  NoonCam
//
//  Created by 김학철 on 2020/06/16.
//  Copyright © 2020 김학철. All rights reserved.
//

import UIKit
import Malert

enum ListType : Int {
    case time, popular, regist
}

class CamTalkListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, RollingViewDelegate {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var ivTropic: UIImageView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var rollingView: RollingView?
    var talkFlowLayout: CamTalkFlowLayout!
    
    var listType:ListType!
    var listdata:[[String:Any]]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listdata = [["title":"그래", "b":"fjdlsf"], ["title":"아리랑", "2":"fjsdf"]]
        if listType == ListType.time {
         
        }
        else if listType == ListType.popular {
         
        }
        else if listType == ListType.regist {
         
        }
        self.view.layoutIfNeeded()
        
        talkFlowLayout = CamTalkFlowLayout()
        collectionView.collectionViewLayout = talkFlowLayout
        
        rollingView = RollingView.instantiateFromNib()
        topView.addSubview(rollingView!)
        
        rollingView!.translatesAutoresizingMaskIntoConstraints = false
        rollingView!.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 0).isActive = true
        rollingView!.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: 0).isActive = true
        rollingView!.topAnchor.constraint(equalTo: topView.topAnchor, constant: 0).isActive = true
        rollingView!.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: 0).isActive = true
        rollingView?.delegate = self
        rollingView!.setupData(data: listdata)
        rollingView!.layer.borderWidth = 1
        rollingView!.layer.borderColor = UIColor.red.cgColor
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
    
    ///UICollectionViewDelegate, UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return listdata.count
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:CamTalkCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CamTalkCell", for: indexPath) as! CamTalkCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: false)
    }
    
    func showTalkAlertView(data:[String:Any]) {
        
        let talkPopView = TalkAlertView.instantiateFromNib()
        talkPopView.setData(data: ["title":"영상채팅"])
        
        
        let alert = Malert(customView:talkPopView)
        alert.buttonsAxis = .vertical
        alert.separetorColor = RGB(230, 230, 230)
        //        alert.cornerRadius = 20.0
        alert.animationType = .fadeIn
        alert.presentDuration = 0.5
        
        let action1 = MalertAction(title: "쪽지")
        let action2 = MalertAction(title: "찜")
        let action3 = MalertAction(title: "신청")
        let action4 = MalertAction(title: "취소")
        
        //        action1.backgroundColor = UIColor(red:0.38, green:0.76, blue:0.15, alpha:1.0)
        
        action1.tintColor = UIColor(red:0.15, green:0.64, blue:0.85, alpha:1.0)
        action2.tintColor = UIColor(red:0.15, green:0.64, blue:0.85, alpha:1.0)
        action3.tintColor = UIColor(red:0.15, green:0.64, blue:0.85, alpha:1.0)
        action4.tintColor = UIColor.red
        
        alert.addAction(action1)
        alert.addAction(action2)
        alert.addAction(action3)
        alert.addAction(action4)
        
        present(alert, animated: true)
    }
    
    //MARK: RollingViewDelegate
    func didClickedRollingItemView(data: [String : Any]) {
        self.showTalkAlertView(data: data)
    }
}




