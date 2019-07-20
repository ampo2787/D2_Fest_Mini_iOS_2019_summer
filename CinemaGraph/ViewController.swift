//
//  ViewController.swift
//  CinemaGraph
//
//  Created by JihoonPark on 16/07/2019.
//  Copyright © 2019 JihoonPark. All rights reserved.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARk: - Local vriables
    var cameraController:UIImagePickerController! = nil
    
    // MARK: - IBOutlets
    
    // MARk: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cameraController = UIImagePickerController.init()
        self.cameraController.delegate = self
    }

    // MARK: - IBActions
    @IBAction func takePictureBtnClicked(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            self.cameraController.sourceType = UIImagePickerController.SourceType.camera
            self.cameraController.allowsEditing = true
            self.cameraController.mediaTypes = UIImagePickerController.availableMediaTypes(for: UIImagePickerController.SourceType.camera)!
            
            self.present(self.cameraController, animated: true, completion: nil)
        }
        else {
            let alertView = UIAlertController(title: "Error", message: "No Camera", preferredStyle: UIAlertController.Style.actionSheet)
            alertView.addAction(UIAlertAction(title:"OK", style: .default, handler: nil))
            self.present(alertView, animated: true, completion: nil)
        }
        
    }
    
    // MARK: - Custom methods
    func takePicture(){
        if self.cameraController.cameraCaptureMode == UIImagePickerController.CameraCaptureMode.photo {
            let alertView = UIAlertController(title: "Error", message: "동영상을 촬영해야 합니다.", preferredStyle: UIAlertController.Style.actionSheet)
            alertView.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
                self.cameraController.cameraCaptureMode = UIImagePickerController.CameraCaptureMode.video
            }))
            self.present(alertView, animated: true, completion: nil)
        }
        else {
            let isSuccess = self.cameraController.startVideoCapture()
            
            if !isSuccess {
                self.cameraController.stopVideoCapture()
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let MediaType = info[UIImagePickerController.InfoKey.mediaType] as? String {
            if MediaType == (kUTTypeImage as String){
                let alertView = UIAlertController(title: "Error", message: "동영상을 편집해야 합니다.", preferredStyle: UIAlertController.Style.actionSheet)
                alertView.addAction(UIAlertAction(title:"OK", style: .default, handler: nil))
                self.present(alertView, animated: true, completion: nil)
            }
            else {
                if let videoURL = info[UIImagePickerController.InfoKey.mediaURL] as? URL {
                    UISaveVideoAtPathToSavedPhotosAlbum(videoURL.relativePath, nil, nil, nil)
                }
            }
            dismiss(animated: true, completion: nil)
        }
    }
    
    
}

