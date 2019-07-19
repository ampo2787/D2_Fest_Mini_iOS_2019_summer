//
//  ViewController.swift
//  CinemaGraph
//
//  Created by JihoonPark on 16/07/2019.
//  Copyright © 2019 JihoonPark. All rights reserved.
//

import UIKit
import MobileCoreServices

class StartVC: UIViewController  {
    var cameraController:UIImagePickerController! = nil
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cameraController = UIImagePickerController.init()
        self.cameraController.delegate = self
    }

    // MARK: - Button Action
    /*
     Camera Open Only Video Mode.
     Show Alert View For No Camera Model
     */
    @IBAction func takePictureBtnClicked(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            self.cameraController.sourceType = .camera
            self.cameraController.allowsEditing = false
            self.cameraController.mediaTypes = [kUTTypeMovie as String]
            
            self.present(self.cameraController, animated: true, completion: nil)
        }
        else {
            let alertView = UIAlertController(title: "Error", message: "No Camera", preferredStyle: UIAlertController.Style.actionSheet)
            alertView.addAction(UIAlertAction(title:"OK", style: .default, handler: nil))
            self.present(alertView, animated: true, completion: nil)
        }
        
    }
    /*
     Album Open Only Video Mode.
     */
    @IBAction func videoSelectFromAlbumBtnClicked(_ sender: UIButton) {
        self.cameraController.sourceType = .photoLibrary
        self.cameraController.mediaTypes = [kUTTypeMovie as String]
        self.present(self.cameraController, animated: true, completion: nil)
    }
    
    // MARK: - ImagePickerDelegate
    /*
    This Function Play After Video Capture
    If Data type is Photo, show alertView.
    else, Video Save UserDefaults.
    */
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let MediaType = info[UIImagePickerController.InfoKey.mediaType] as? String {
            if MediaType == (kUTTypeImage as String){
                let alertView = UIAlertController(title: "Error", message: "동영상을 편집해야 합니다.", preferredStyle: UIAlertController.Style.actionSheet)
                alertView.addAction(UIAlertAction(title:"OK", style: .default, handler: nil))
                self.present(alertView, animated: true, completion: nil)
            }
            else {
                if let videoURL = info[UIImagePickerController.InfoKey.mediaURL] as? URL {
                    UserDefaults.standard.set(videoURL, forKey: "Selected_Video")
                    UserDefaults.standard.synchronize()
                    
                    //This code is save Video to album.
                    //UISaveVideoAtPathToSavedPhotosAlbum(videoURL.relativePath, nil, nil, nil)
                }
            }
            dismiss(animated: true, completion: nil)
        }
    }
    
    
}

extension UIViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
}

