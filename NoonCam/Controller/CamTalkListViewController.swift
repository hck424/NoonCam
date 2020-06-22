//
//  CamTalkListViewController.swift
//  NoonCam
//
//  Created by 김학철 on 2020/06/16.
//  Copyright © 2020 김학철. All rights reserved.
//

import UIKit


class CamTalkListViewController: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegate, RollingViewDelegate , UIScrollViewDelegate {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var ivTropic: UIImageView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var rollingView: RollingView?
    var talkFlowLayout: CamTalkFlowLayout!
    
    var listType:CamTalkType!
    
    var listData:[CamTalk] = []
    var hotList:[CamTalk] = []
    var pageNum = 1
    var totalPage = 1
    
    var isRequest: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listType = .all
        
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
        

        self.requestCamTalkList()
      
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
    
    func requestCamTalkList() {
        if pageNum > totalPage { return }
        if pageNum == 1 {
            hotList.removeAll()
            listData.removeAll()
        }
        let param = ["clientPara":["user_id": "\(ShareData.shared.myId!)",
            "pageNum": NSNumber(value: pageNum),
            "search_sex": "\(ShareData.shared.myGender.opposit().value)",
            "my_sex": "\(ShareData.shared.myGender.value)",
            "search_top": "\(listType.value)"]]
        
        isRequest = true
        ApiManager.shared.requestCamTalkList(param, success: { result in
            self.isRequest = false
            if let list = result?["result"] as? [CamTalk] {
                self.listData.append(contentsOf: list)
            }
            
            if let hot = result?["hot"] as? [CamTalk] {
                self.hotList.append(contentsOf: hot)
            }
            self.totalPage = result!["bbsCount"] as! Int
            
            self.collectionView.reloadData()
            
            if (self.pageNum == 1) {
                self.rollingView?.setupData(self.hotList)
            }
            
            self.pageNum += 1
        }) { error in
            print(error?.localizedDescription ?? "")
        }
    }
    
    ///UICollectionViewDelegate, UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:CamTalkCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CamTalkCell", for: indexPath) as! CamTalkCell
        
        let talk: CamTalk = listData[indexPath.row]
        cell.configurationData(talk)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        let talk:CamTalk = listData[indexPath.row]
        showTalkAlertView(talk)
    }
    
    //MARK: RollingViewDelegate
    func didClickedRollingItemView(_ talk: CamTalk) {
        self.showTalkAlertView(talk)
    }
    
    //MARK: UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let velocityY : CGFloat = scrollView.panGestureRecognizer.translation(in: scrollView.superview).y
        let contentOffsetY : CGFloat = scrollView.contentOffset.y + scrollView.frame.size.height
        let contnetSizeH : CGFloat = scrollView.contentSize.height
        
        if velocityY < 0 && contentOffsetY > contnetSizeH && isRequest == false {
            self.requestCamTalkList()
        }
    }
}




