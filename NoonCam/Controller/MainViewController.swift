//
//  MainViewController.swift
//  NoonCam
//
//  Created by 김학철 on 2020/06/16.
//  Copyright © 2020 김학철. All rights reserved.
//

import UIKit
import SideMenu


class MainViewController: UIViewController, UITabBarControllerDelegate {
    @IBOutlet weak var noticeView: UIView!
    @IBOutlet weak var containerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.changeNaviTitle(index: 0)
    }
    
    @IBAction func onCloseAction(_ sender: Any) {
        noticeView.isHidden = false
    }
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "left" {
            guard let sideMenuNavigationController = segue.destination as? SideMenuNavigationController else { return }
            sideMenuNavigationController.settings = makeSettings()
        }
        else if segue.identifier == "tabBar" {
            guard let tabViewController = segue.destination as? UITabBarController else { return }
            tabViewController.delegate = self;
        }
    }
    
    private func selectedPresentationStyle() -> SideMenuPresentationStyle {
        let modes: [SideMenuPresentationStyle] = [.menuSlideIn, .viewSlideOut, .viewSlideOutMenuIn, .menuDissolveIn]
        return modes[1]
    }
    
    private func makeSettings() -> SideMenuSettings {
        let presentationStyle = selectedPresentationStyle()
        presentationStyle.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "background"))
        presentationStyle.menuStartAlpha = CGFloat(1.0)
        presentationStyle.menuScaleFactor = CGFloat(1.0)
        presentationStyle.onTopShadowOpacity = 0.0
        presentationStyle.presentingEndAlpha = CGFloat(1.0)
        presentationStyle.presentingScaleFactor = CGFloat(1.0)
        
        var settings = SideMenuSettings()
        settings.presentationStyle = presentationStyle
        settings.menuWidth = min(view.frame.width, view.frame.height) * CGFloat(0.5)
        let styles:[UIBlurEffect.Style?] = [nil, .dark, .light, .extraLight]
        settings.blurEffectStyle = styles[2]
        settings.statusBarEndAlpha = 0
        
        return settings
    }
    
    
    /// UITabBarControllerDelegate
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected view controller")
        print (tabBarController.selectedIndex)
        self.changeNaviTitle(index: tabBarController.selectedIndex);
    }
    
    func changeNaviTitle(index:Int) {
        var title:String = "영상"
        if index == 1 {
            title = "토크"
        }
        else if index == 2 {
            title = "충전"
        }
        else if index == 3 {
            title = "쪽지"
        }
        else {
            title = "영상"
        }
        self.navigationItem.title = title
    }
}
