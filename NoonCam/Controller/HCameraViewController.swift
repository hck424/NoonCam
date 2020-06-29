//
//  HCameraViewController.swift
//  NoonCam
//
//  Created by 김학철 on 2020/06/22.
//  Copyright © 2020 김학철. All rights reserved.
//

import UIKit
import AVFoundation
import CropViewController

class HCameraViewController: UIViewController {
    
    @IBOutlet var overlayView: UIView!
    @IBOutlet weak var btnShot: UIButton!
    @IBOutlet weak var btnClose: UIButton!
    
    var picker:UIImagePickerController?
    var soureType:UIImagePickerController.SourceType?
    
    var didFinishImagesWithClosure:(((_ originImg:UIImage?, _ cropImg: UIImage?) ->()))?
    
    var orgImage:UIImage?
    var cropImag:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnShot.layer.cornerRadius = 40.0
        
        self.checkPermissionAfterShowImagePicker()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
        picker = UIImagePickerController.init()
        guard let picker = picker else {
            return
        }
        
        picker.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        picker.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        picker.sourceType = soureType!
        picker.delegate = self
        if picker.sourceType == UIImagePickerController.SourceType.camera {
            picker.isNavigationBarHidden = true
            picker.isToolbarHidden = true
            picker.allowsEditing = false
            picker.showsCameraControls = false
            

            let screenSize = UIScreen.main.bounds.size // 320 x 568
            
            let scale = Float(screenSize.height / screenSize.width * 3 / 4)
            let translate = CGAffineTransform(translationX: 0, y: (screenSize.height - screenSize.width * 4 / 3) * 0.5)
            let fullScreen = CGAffineTransform(scaleX: CGFloat(scale), y: CGFloat(scale))
            picker.cameraViewTransform = fullScreen.concatenating(translate)
            overlayView.frame = CGRect.init(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
            
            picker.cameraOverlayView = overlayView
        }
        else {
            picker.allowsEditing = false
        }
        present(picker, animated: false, completion: nil)
    }
    
    @IBAction func onClickedButtonActions(_ sender: UIButton) {
        if sender == btnShot {
            picker!.takePicture()
        }
        else if sender == btnClose {
            self.popViewController()
        }
    }
    
    func popViewController() {
        if let presnetedVC = presentedViewController {
            presnetedVC.dismiss(animated: false, completion: nil)
        }
        self.navigationController?.popViewController(animated: false)
    }
}

extension HCameraViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
    
        orgImage = image
        picker.dismiss(animated: false) {
            let vc = CropViewController.init(croppingStyle: CropViewCroppingStyle.default, image: self.orgImage!)
            vc.delegate = self
            vc.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.present(vc, animated: false, completion: nil)
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: false) {
            self.navigationController?.popViewController(animated: false)
        }
    }
}
extension HCameraViewController : CropViewControllerDelegate {
    
    func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        cropViewController.dismiss(animated: false) {
            self.navigationController?.popViewController(animated: false)
            self.didFinishImagesWithClosure!(self.orgImage, image)
        }
    }
    
    func cropViewController(_ cropViewController: CropViewController, didFinishCancelled cancelled: Bool) {
        cropViewController.dismiss(animated: false) {
            self.displayImagePicker()
        }
    }
}
