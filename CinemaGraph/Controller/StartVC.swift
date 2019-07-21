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
    // MARK: - Variables
    // MARK: IBOutlets
    @IBOutlet weak var itemScrollView: UIScrollView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var videoButton: UIButton!
    
    @IBOutlet weak var loadVideoButton: UIButton!
    @IBOutlet weak var loadViedoText: UILabel!
    
    @IBOutlet weak var footerStackView: UIStackView!
    @IBOutlet weak var footerView: UIView!
    
    // MARK: Local Var
    var cameraController:UIImagePickerController! = nil
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cameraController = UIImagePickerController.init()
        self.cameraController.delegate = self
        
        self.setSrollViewOptions()
        self.makeButtonUI()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.updateButtonUI()
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
    
    @IBAction func complieButtonTouched(_ sender: UIButton) {
        itemScrollView.isHidden = true
        footerStackView.isHidden = true
        
        UIView.animate(withDuration: 1.5, delay: 1.0, options: .curveEaseIn, animations: {
            self.footerView.isHidden = false
        }, completion: nil)
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
    
    
    // MARK: - Custom Methods
    // MARK: UI Methods
    private func makeButtonUI() {
        let bWidth = CGFloat(1.0)
        let bColor = UIColor(displayP3Red: 164/255, green: 200/255, blue: 250/255, alpha: 1.0).cgColor
        
        saveButton.layer.borderWidth = bWidth
        videoButton.layer.borderWidth = bWidth
        saveButton.layer.borderColor = bColor
        videoButton.layer.borderColor = bColor
    }
    
    private func updateButtonUI() {
        let cRadius = saveButton.frame.height/2
        
        saveButton.layer.cornerRadius = cRadius
        videoButton.layer.cornerRadius = cRadius
    }
    
    /*
     앨범 가져오기 버튼과 Text를 가린다.
     photo library 에서 video를 선택 후 호출
     */
    private func didLoadPhotoLibrary() {
        loadVideoButton.isHidden = true
        loadViedoText.isHidden = true
    }
    
    
}

extension StartVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
}

extension StartVC : UIScrollViewDelegate {
    func setSrollViewOptions() {
        itemScrollView.delegate = self
        itemScrollView.showsVerticalScrollIndicator = false
        itemScrollView.showsHorizontalScrollIndicator = false
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Remove bounces of scroll view.
        // If you want to bounce like only right bouce,
        // code "itemScrollView.contentOffset.x > 0"
        itemScrollView.bounces = false
    }
}
