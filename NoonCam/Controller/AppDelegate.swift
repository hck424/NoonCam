//
//  AppDelegate.swift
//  NoonCam
//
//  Created by 김학철 on 2020/06/16.
//  Copyright © 2020 김학철. All rights reserved.
//

import UIKit
import CoreData

let TAG_LOADING_IMG = 111000
let Pai:Double = 3.14159

extension UIView {
    func startAnimation(raduis: CGFloat) {
        let imageName = "icon_loading"

        let indicator = viewWithTag(TAG_LOADING_IMG) as? UIImageView
        if indicator != nil {
            indicator?.removeFromSuperview()
        }

        isHidden = false
        superview?.bringSubviewToFront(self)

        let ivIndicator = UIImageView(frame: CGRect(x: 0, y: 0, width: 2 * raduis, height: 2 * raduis))
        ivIndicator.tag = TAG_LOADING_IMG
        ivIndicator.contentMode = .scaleAspectFit
        ivIndicator.image = UIImage(named: imageName)
        addSubview(ivIndicator)
        indicator?.layer.borderWidth = 1.0
        indicator?.layer.borderColor = UIColor.red.cgColor
        ivIndicator.frame = CGRect(x: (frame.size.width - ivIndicator.frame.size.width) / 2, y: (frame.size.height - ivIndicator.frame.size.height) / 2, width: ivIndicator.frame.size.width, height: ivIndicator.frame.size.height)

        let rotation = CABasicAnimation(keyPath: "transform.rotation")
        rotation.fromValue = NSNumber(value: 0.0)
        rotation.toValue = NSNumber(value: -2 * Pai)
        rotation.duration = 1
        rotation.repeatCount = .infinity

        ivIndicator.layer.add(rotation, forKey: "loading")

    }
    func stopAnimation() {
        isHidden = true
        let indicator = viewWithTag(TAG_LOADING_IMG) as? UIImageView
        if indicator != nil {
            indicator?.layer.removeAnimation(forKey: "loading")
            //        [indicator removeFromSuperview];
        }
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window:UIWindow?
    
    var mainNaviController: MainNavigationController?
    
    var loadingView: UIView?
    
    func getMainMainNavi() -> MainNavigationController {
        return self.window?.rootViewController as! MainNavigationController
    }
    class func instance() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
 
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if #available(iOS 13.0, *) {
           
        }
        else {
            self.window = UIWindow.init(frame: UIScreen.main.bounds)
            self.callIntroViewController()
        }
//        CValiable.shared.myArea = UserDefaults.standard.object(forKey: "USER_AREA") as? String
//        ShareData.shared.myArea = "서울"
        return true
    }

    func callIntroMainViewController () {
        let stroyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        self.mainNaviController = (stroyboard.instantiateViewController(withIdentifier: "MainNavigationController") as? MainNavigationController)!
        
        if self.window == nil {
            self.window = SceneDelegate.instance()?.window
        }
        self.window!.rootViewController = mainNaviController
        self.window!.makeKeyAndVisible()
    }
    
    func callIntroViewController () {
        let stroyboard:UIStoryboard = UIStoryboard(name: "Intro", bundle: nil)
        let vc = stroyboard.instantiateViewController(withIdentifier: "IntroViewController") as? IntroViewController
        if self.window == nil {
            self.window = SceneDelegate.instance()?.window
        }
        self.window!.rootViewController = vc!
        self.window!.makeKeyAndVisible()
    }
    
    func callMemberRegistViewController() {
        let stroyboard:UIStoryboard = UIStoryboard(name: "Intro", bundle: nil)
        let termNavi = stroyboard.instantiateViewController(withIdentifier: "TermNavigationController") as? TermNavigationController
        let termVC = stroyboard.instantiateViewController(withIdentifier: "TermViewController") as? TermViewController
        termVC?.mode = "yk1"
        termVC?.type = .regist
        termNavi?.viewControllers = [termVC!]
        if self.window == nil {
            self.window = SceneDelegate.instance()?.window
        }
        self.window!.rootViewController = termNavi
        self.window!.makeKeyAndVisible()
    }
    
    func startIndicator() {
        DispatchQueue.main.async(execute: {
            if self.loadingView == nil {
                self.loadingView = UIView(frame: UIScreen.main.bounds)
            }
            if self.window == nil {
                self.window = SceneDelegate.instance()?.window
            }
            self.window!.addSubview(self.loadingView!)
            self.loadingView?.startAnimation(raduis: 25.0)
        })
    }

    
    func stopIndicator() {
        DispatchQueue.main.async(execute: {
            if self.loadingView != nil {
                self.loadingView!.stopAnimation()
                self.loadingView?.removeFromSuperview()
            }
        })
    }
    
   
    // MARK: UISceneSession Lifecycle
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "NoonCam")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

