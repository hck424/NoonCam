//
//  HCameraViewController.swift
//  NoonCam
//
//  Created by 김학철 on 2020/06/22.
//  Copyright © 2020 김학철. All rights reserved.
//

import UIKit
import AVFoundation

class HCameraViewController: UIViewController {
    
    @IBOutlet var cameraOverlayView: UIView!
    @IBOutlet weak var btnShot: UIButton!
    @IBOutlet weak var btnClose: UIButton!
    
    var sourceType:UIImagePickerController.SourceType?
    var didFinishImagesWithClosure:(((_ originImg:UIImage?, _ cropImg: UIImage?) ->()))?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.checkPermissionAfterShowImagePicker()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func checkPermissionAfterShowImagePicker() {
        let authStatus: AVAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        if authStatus == AVAuthorizationStatus.denied {
            let alert = UIAlertController.init(title: "카메라에 액세스 할 수 없습니다", message: "액세스를 활성화하려면 설정> 개인 정보 보호> 카메라로 이동하여이 앱에 대한 카메라 액세스를 켜십시오", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction.init(title: "취소", style: UIAlertAction.Style.cancel, handler: { (action) in
                alert.dismiss(animated: false, completion: nil)
            }))
            alert.addAction(UIAlertAction.init(title: "설정", style: UIAlertAction.Style.default, handler: { (action) in
                guard let url = URL.init(string: UIApplication.openSettingsURLString) else {
                    alert.dismiss(animated: false, completion: nil)
                    return
                }
                
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared .open(url, options: [:], completionHandler: nil)
                }
                else {
                    alert.dismiss(animated: false, completion: nil)
                }
            }))
            self.present(alert, animated: false, completion: nil)
        }
        else if authStatus == AVAuthorizationStatus.notDetermined {
            AVCaptureDevice.requestAccess(for: AVMediaType.video) { (granted:Bool) in
                if granted {
                    DispatchQueue.main.async(execute: {
                        self.displayImagePicker()
                    })
                }
            }
        }
        else {
            self.displayImagePicker()
        }
        
    }
    
    func displayImagePicker() {
        let picker = UIImagePickerController.init()
        picker.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        picker.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        picker.sourceType = sourceType!
        
        if sourceType! == UIImagePickerController.SourceType.camera {
            picker.isNavigationBarHidden = true
            picker.isToolbarHidden = true
            picker.allowsEditing = false
            picker.showsCameraControls = false
            

        }
        else {
            
        }
        self.present(picker, animated: true, completion: nil)
    }
    
    @IBAction func onClickedButtonActions(_ sender: UIButton) {
    }
    
}

extension HCameraViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
    }
}
