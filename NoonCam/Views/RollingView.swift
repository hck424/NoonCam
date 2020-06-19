//
//  RollingView.swift
//  NoonCam
//
//  Created by 김학철 on 2020/06/17.
//  Copyright © 2020 김학철. All rights reserved.
//

import UIKit
protocol RollingViewDelegate {
    func didClickedRollingItemView(data:[String:Any])
}

class RollingView: UIView, UIScrollViewDelegate, ItemViewDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var svContent: UIStackView!
    var arrData:[[String:Any]] = []
    
    var timer:Timer?
    let heightContent:CGFloat = 70.0
    var curIndex:Int = 0
    let timerInterval:CGFloat = 1.5
    var delegate:RollingViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        scrollView.delegate = self
    }
    
    func setupData(data:[[String:Any]]?) {
        
        for subview in svContent.subviews {
            subview.removeFromSuperview()
        }
        
        guard let data = data else { return }
        
        if let lastObject = data.last {
            arrData.append(lastObject)
        }
        arrData.append(contentsOf: data)
        if let firstObject = data.first {
            arrData.append(firstObject)
        }
        
        self.layoutIfNeeded()
        for i:Int in 0..<arrData.count {
            let item = arrData[i]
            let itemView = ItemView.instantiateFromNib()
            svContent.addArrangedSubview(itemView)
            itemView.delegate = self
            itemView.translatesAutoresizingMaskIntoConstraints = false
            itemView.heightAnchor.constraint(equalToConstant: heightContent).isActive = true
            itemView.layoutIfNeeded()
            itemView.setData(data:item, index:i)
        }
        
        
        curIndex = arrData.count - 1
        scrollView.setContentOffset(CGPoint(x: 0, y: curIndex*Int(heightContent)), animated: false)
        self.addtimer()
    }

    func addtimer() {
        stopTimer()
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(timerInterval), target: self, selector: #selector(nextStep), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: .common)
    }
    
    func stopTimer() {
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
    }
    
    @objc func nextStep() {
        scrollView.setContentOffset(CGPoint(x: 0, y: (curIndex-1)*Int(heightContent)), animated: true)
    }
    
   //MARK: ScrollViewDelegate
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        self.scrollViewDidEndDecelerating(scrollView)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = (Int)(scrollView.contentOffset.y / heightContent)
        if index == 0  {
            curIndex = arrData.count - 1
            scrollView.setContentOffset(CGPoint(x: 0, y: curIndex*Int(heightContent)), animated: false)
        }
        else {
            curIndex -= 1
        }
    }
    
    class func instantiateFromNib() -> RollingView {
        return  Bundle.main.loadNibNamed("RollingView", owner: self, options: nil)?.first as! RollingView
    }
    
    //MARK: ItemViewDelegate
    func didClickedItemView(data: [String : Any]) {
        if let delegate = delegate {
            delegate.didClickedRollingItemView(data:data)
        }
    }
}
