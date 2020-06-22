//
//  BaseViewController.swift
//  NoonCam
//
//  Created by 김학철 on 2020/06/21.
//  Copyright © 2020 김학철. All rights reserved.
//

import UIKit
import Malert
import INSPhotoGallery

class BaseViewController: UIViewController, TalkAlertViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func showTalkAlertView(_ talk: CamTalk) {
        
        let talkPopView = TalkAlertView.instantiateFromNib()
        talkPopView.delegate = self
        talkPopView.setData(talk)
        
        let alert = Malert(customView:talkPopView)
        alert.buttonsAxis = .vertical
        //        alert.buttonsAxis = .horizontal
        alert.separetorColor = RGB(230, 230, 230)
        //        alert.cornerRadius = 20.0
        alert.animationType = .fadeIn
        alert.presentDuration = 0.5
        
        let action1 = MalertAction(title: "쪽지") {
            print("쪽지")
        }
        let action2 = MalertAction(title: "찜") {
            print("찜")
        }
        let action3 = MalertAction(title: "신청") {
            print("신청")
        }
        let action4 = MalertAction(title: "취소" ) {
            print("취소")
        }
        
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
    
    func myAddChildViewController(superView:UIView, childViewController:UIViewController) {
        addChild(childViewController)
        
        childViewController.beginAppearanceTransition(true, animated: true)
        if let view = childViewController.view {
            superView.addSubview(view)
        }
        
        childViewController.view.frame = superView.bounds
        childViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        childViewController.endAppearanceTransition()
        childViewController.didMove(toParent: self)
    }
    
    func myRemoveChildViewController(childViewController:UIViewController) {
        childViewController.beginAppearanceTransition(false, animated: true)
        childViewController.view.removeFromSuperview()
        childViewController.endAppearanceTransition()
    }
    
    //MARK: TalkAlertViewDelegate
    func showPhoto(targetView:UIImageView, imageUrls: [String]) {
        
        let photos: [INSPhotoViewable] = {
            return [
                INSPhoto(imageURL: URL(string: imageUrls.first!), thumbnailImage: nil)
            ]
        }()
        
        
        let galleryPreview = INSPhotosViewController(photos: photos, initialPhoto: photos.first, referenceView: targetView)
        galleryPreview.navigationController?.navigationBar.isHidden = false
        
//        if useCustomOverlay {
//            galleryPreview.overlayView = CustomOverlayView(frame: CGRect.zero)
//        }
        
//        galleryPreview.referenceViewForPhotoWhenDismissingHandler = { [weak self] photo in
//            return nil
//        }
        
        if let  curPresentvc = self.presentedViewController {
            curPresentvc.present(galleryPreview, animated: false, completion: nil)
        }
        else {
            present(galleryPreview, animated: true, completion: nil)
        }
    }
}
