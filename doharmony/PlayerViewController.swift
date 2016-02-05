//
//  PlayerViewController.swift
//  doharmony
//
//  Created by Eleazer Toluan on 2/3/16.
//  Copyright © 2016 khemer sone andres. All rights reserved.
//

import UIKit

class PlayerViewController: UIViewController {

    @IBOutlet weak var PlayerDisplay: UIView!
    
    @IBOutlet weak var TitleLabel: UILabel!
 
    @IBOutlet weak var imageView: UIImageView!
    
    var image = UIImage()
//    var title = UILabel()!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageView.image = self.image
//        self.TitleLabel.text = self.title
        PlayerDisplay.contentMode = .ScaleAspectFit
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
