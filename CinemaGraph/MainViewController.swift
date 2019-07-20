//
//  MainViewController.swift
//  CinemaGraph
//
//  Created by 이운형 on 20/07/2019.
//  Copyright © 2019 JihoonPark. All rights reserved.
//

import UIKit

class MainViewController: UIViewController{

    @IBOutlet weak var itemScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setSrollViewOptions()
        // Do any additional setup after loading the view.
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
