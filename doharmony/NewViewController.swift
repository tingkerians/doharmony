//
//  NewViewController.swift
//  doharmony
//
//  Created by kimpoy on 2/1/16.
//  Copyright © 2016 khemer sone andres. All rights reserved.
//

import UIKit

class NewViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var image = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageView.image = self.image
        
    }
}
