//
//  MainViewController.swift
//  CinemaGraph
//
//  Created by 이운형 on 20/07/2019.
//  Copyright © 2019 JihoonPark. All rights reserved.
//

import UIKit

class MainViewController: UIViewController{
    // MARK: - Variables
    // MARK: IBOutlets
    @IBOutlet weak var itemScrollView: UIScrollView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var videoButton: UIButton!
    
    @IBOutlet weak var loadVideoButton: UIButton!
    @IBOutlet weak var loadViedoText: UILabel!
    
    @IBOutlet weak var footerStackView: UIStackView!
    @IBOutlet weak var footerView: UIView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setSrollViewOptions()
        self.makeButtonUI()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.updateButtonUI()
    }
    
    // MARK: - IBActions
    @IBAction func complieButtonTouched(_ sender: UIButton) {
        itemScrollView.isHidden = true
        footerStackView.isHidden = true
        
        UIView.animate(withDuration: 1.5, delay: 1.0, options: .curveEaseIn, animations: {
            self.footerView.isHidden = false
        }, completion: nil)
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

extension MainViewController : UIScrollViewDelegate {
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
