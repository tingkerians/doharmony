//
//  InfoViewController.swift
//  doharmony
//
//  Created by kimpoy on 1/27/16.
//  Copyright © 2016 khemer sone andres. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet var closeBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func closePressed(b:UIButton){
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
}
