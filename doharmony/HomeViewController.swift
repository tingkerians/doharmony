//
//  HomeViewController.swift
//  doharmony
//
//  Created by kimpoy on 1/26/16.
//  Copyright © 2016 khemer sone andres. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    

    @IBOutlet var MainScroll: UIScrollView!
    @IBOutlet var NewTracksScroll: UIScrollView!
    @IBOutlet var RecomendedTracksScroll: UIScrollView!
    @IBOutlet var LatestTracksScroll: UIScrollView!
    
  
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
      
        MainScroll.contentSize.height = 600
        NewTracksScroll.contentSize.width = 950
        RecomendedTracksScroll.contentSize.width = 950
        LatestTracksScroll.contentSize.width = 950
    }
    
   
}
