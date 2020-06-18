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

class CamTalkListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var ivTropic: UIImageView!
    @IBOutlet weak var rollingView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var talkFlowLayout: CamTalkFlowLayout!
    
    var listType:ListType!
    var listdata:[[String:String]] = [["a":"fdalf", "b":"fjdlsf"], ["1":"djfskla", "2":"fjsdf"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if listType == ListType.time {
         
        }
        else if listType == ListType.popular {
         
        }
        else if listType == ListType.regist {
         
        }
        
        talkFlowLayout = CamTalkFlowLayout()
        collectionView.collectionViewLayout = talkFlowLayout
        
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
}
