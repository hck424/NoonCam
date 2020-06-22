//
//  CamTalkFlowLayout.swift
//  NoonCam
//
//  Created by 김학철 on 2020/06/17.
//  Copyright © 2020 김학철. All rights reserved.
//

import UIKit

class CamTalkFlowLayout: UICollectionViewFlowLayout {
    let spaceing: CGFloat = 2.0
    override init() {
        super.init()
        seupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder:coder)
        seupLayout()
    }
    override var itemSize:CGSize {
        set {}
        get {
            let numberOfColumns: CGFloat = 3.0
            let itemWith = (self.collectionView!.frame.width - (numberOfColumns * spaceing))/numberOfColumns
            
            return CGSize(width: itemWith, height: 160)
        }
    }
    
    func seupLayout() {
        minimumInteritemSpacing = spaceing
        minimumLineSpacing = spaceing
        scrollDirection = .vertical
    }
}
