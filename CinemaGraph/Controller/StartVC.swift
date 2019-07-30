//
//  ViewController.swift
//  CinemaGraph
//
//  Created by JihoonPark on 16/07/2019.
//  Copyright © 2019 JihoonPark. All rights reserved.
//

import UIKit
import MobileCoreServices
import AVKit

class StartVC: UIViewController  {
    // MARK: - Variables
    // MARK: IBOutlets
    @IBOutlet weak var itemScrollView: UIScrollView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var videoButton: UIButton!
    @IBOutlet weak var gifView: UIView!
    
    @IBOutlet weak var loadVideoButton: UIButton!
    @IBOutlet weak var loadViedoText: UILabel!
    
    @IBOutlet weak var footerStackView: UIStackView!
    @IBOutlet weak var footerView: UIView!
    var heightOfFooterView: CGFloat = 0
    
    // MARK: Local Var
    var cameraController:UIImagePickerController! = nil
    var convert_imageToMovie:Convert_ImageToMovie! = nil
    var convert_movieToImage:Convert_MovieToImage! = nil
    var exportImage:[UIImage] = []
    
    var frameExtracter:Convert_FrameExtract!
    let imageView = UIImageView.init()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cameraController = UIImagePickerController.init()
        self.cameraController.delegate = self

        convert_imageToMovie = Convert_ImageToMovie.init()
        convert_movieToImage = Convert_MovieToImage.init()
        frameExtracter=Convert_FrameExtract()
        
        self.frameExtracter.delegate = self
        self.imageView.bounds = self.gifView.bounds
        self.gifView.addSubview(imageView)
        
        self.setSrollViewOptions()
        self.makeButtonUI()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.updateButtonUI()
        heightOfFooterView = footerView.frame.height
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
        showFooterView()
    }
    
    @IBAction func cancelButtonTouched(_ sender: UIButton) {
        hideFooterView()
        itemScrollView.isHidden = false
        footerStackView.isHidden = false
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
                    self.loadViedoText.isHidden = true
                    self.loadVideoButton.isHidden = true
                    
                    //gifView.addsubLayer for video play
                    let player = AVPlayer(url: videoURL)
                    let playerLayer = AVPlayerLayer(player: player)
                    playerLayer.frame = self.gifView.bounds
                    self.gifView.layer.addSublayer(playerLayer)
                    
                    player.play()
                    
                    /*
                     This code is for video loop
                    */
                    NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { _ in
                        player.seek(to: CMTime.zero)
                        player.play()
                    }
                    
                    /*
                     This code is for asyncronous Get Frame
                     */
                    /*
                    DispatchQueue.global().async {
                        self.convert_movieToImage.getAllFrames(videoUrl: videoURL)
                        self.exportImage = self.convert_movieToImage.frames
                        
                        //memory issue fix
                        self.convert_movieToImage.frames = []
                        
                        DispatchQueue.init(label: "movie save").async {
                            self.convert_imageToMovie.selectedPhotosArray = self.exportImage
                            
                            self.exportImage = []
                            self.convert_imageToMovie.buildVideoFromImageArray()
                            
                            print(self.convert_imageToMovie.imageArrayToVideoURL)
                        }
                    }
                    */
                }
            }
            dismiss(animated: true, completion: nil)
        }
    }
    
    
    
    // MARK: - Custom Methods
    // MARK: UI Methods
    private func makeButtonUI() {
        let bWidth = CGFloat(1.0)
        let bColor = UIColor(displayP3Red: 169/255, green: 147/255, blue: 247/255, alpha: 1.0).cgColor
        
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
    
    private func showFooterView() {
        self.footerView.frame.origin.y += self.heightOfFooterView
        UIView.animate(withDuration: 0.3) {
            self.footerView.isHidden = false
            self.footerView.frame.origin.y -= self.heightOfFooterView
            self.view.layoutIfNeeded()
        }
    }
    
    private func hideFooterView() {
        self.footerView.isHidden = true
    }
    
}

extension StartVC : UIScrollViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate , FrameExtractorDelegate {
    
    func captured(image: UIImage) {
        self.imageView.image = image
    }
    
    
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
