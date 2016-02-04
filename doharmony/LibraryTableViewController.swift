//
//  LibraryTableViewController.swift
//  doharmony
//
//  Created by kimpoy on 1/29/16.
//  Copyright © 2016 khemer sone andres. All rights reserved.
//

import UIKit

class LibraryTableViewController: UIViewController {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }

}
