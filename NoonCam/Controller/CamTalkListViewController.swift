//
//  CamTalkListViewController.swift
//  NoonCam
//
//  Created by 김학철 on 2020/06/16.
//  Copyright © 2020 김학철. All rights reserved.
//

import UIKit

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
    

}
