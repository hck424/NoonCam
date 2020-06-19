//
//  RollingView.swift
//  NoonCam
//
//  Created by 김학철 on 2020/06/17.
//  Copyright © 2020 김학철. All rights reserved.
//

import UIKit

class RollingView: UIView, UIScrollViewDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var svContent: UIStackView!
    var arrData:[AnyHashable] = []
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
      }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
    
    func setupView(data:[AnyHashable]) {
        
        if let firstObject = data.first {
            arrData.append(firstObject)
        }
        arrData.append(contentsOf: data)
        if let lastObject = data.last {
            arrData.append(lastObject)
        }
        var i = 0
        for data in arrData {
//            let itemView = ItemView.instantiateFromNib()
//            itemView.setData(data:data, index:i)
//            itemView.translatesAutoresizingMaskIntoConstraints = false
//            itemView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 1, constant: 0).isActive = true
//
//            svContent.addArrangedSubview(itemView)
            i += 1
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    class func instantiateFromNib() -> RollingView {
        return Bundle.main.loadNibNamed("RollingView", owner: nil, options: nil)!.first as! RollingView
    }
}
