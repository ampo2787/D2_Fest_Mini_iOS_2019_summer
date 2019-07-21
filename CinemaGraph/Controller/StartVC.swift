//
//  ViewController.swift
//  CinemaGraph
//
//  Created by JihoonPark on 16/07/2019.
//  Copyright © 2019 JihoonPark. All rights reserved.
//

import UIKit
import MobileCoreServices

<<<<<<< HEAD:CinemaGraph/ViewController.swift
class ViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARk: - Local vriables
    var cameraController:UIImagePickerController! = nil
    
    // MARK: - IBOutlets
    
    // MARk: - Life cycles
=======
class StartVC: UIViewController  {
    var cameraController:UIImagePickerController! = nil
    
    // MARK: - Life Cycle
>>>>>>> 4e9ba6d635f2225a31d8d0a3fb6ef92db048a084:CinemaGraph/Controller/StartVC.swift
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cameraController = UIImagePickerController.init()
        self.cameraController.delegate = self
    }

<<<<<<< HEAD:CinemaGraph/ViewController.swift
    // MARK: - IBActions
=======
    // MARK: - Button Action
    /*
     Camera Open Only Video Mode.
     Show Alert View For No Camera Model
     */
>>>>>>> 4e9ba6d635f2225a31d8d0a3fb6ef92db048a084:CinemaGraph/Controller/StartVC.swift
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
<<<<<<< HEAD:CinemaGraph/ViewController.swift
    
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
=======
    /*
     Album Open Only Video Mode.
     */
    @IBAction func videoSelectFromAlbumBtnClicked(_ sender: UIButton) {
        self.cameraController.sourceType = .photoLibrary
        self.cameraController.mediaTypes = [kUTTypeMovie as String]
        self.present(self.cameraController, animated: true, completion: nil)
>>>>>>> 4e9ba6d635f2225a31d8d0a3fb6ef92db048a084:CinemaGraph/Controller/StartVC.swift
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

