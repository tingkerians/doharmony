//
//  RecordingViewController.swift
//  doharmony
//
//  Created by eleazer on 31/01/2016.
//  Copyright © 2016 khemer sone andres. All rights reserved.
//

import UIKit

class RecordingViewController: UIViewController {
   
    
    func dupe(template:UIView){
        
        let newTemplate = UIView.init(frame: CGRectMake(10, 10, template.frame.width * 3.7 - 10 , template.frame.height * 3.7 - 10))
        newTemplate.backgroundColor = UIColor.whiteColor()
        newTemplate.contentMode = .ScaleAspectFit
        print(template.frame.width)
        print(template.frame.height)
        self.view.addSubview(newTemplate)
        
//        let horizontalConstraint = newTemplate.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor, constant: 80)
//        let verticalConstraint = newTemplate.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor)
//        NSLayoutConstraint.activateConstraints([horizontalConstraint])
        
        newTemplate.center = self.view.center
        
        for sv:UIView in template.subviews{
            let x = sv.frame.origin.x * 3.7 - 10
            let y = sv.frame.origin.y * 3.7 - 10
            let w = sv.frame.width * 3.7 + 10
            let h = sv.frame.height * 3.7 + 10
            
            let size = CGRectMake(x, y, w, h)
            let frame:UIView = UIView.init(frame: size)
            frame.backgroundColor = UIColor.darkGrayColor()
            //frame.contentMode = .ScaleAspectFit
            newTemplate.addSubview(frame)
            print("Frame x1 \(sv.frame.origin.x)")
            print("Frame x2 \(x)")
            print("Frame y1 \(sv.frame.origin.y)")
            print("Frame y2 \(y)")
            print("Frame size: \(size)")
        }
    }


    @IBAction func CloseButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(false, completion: nil)
    }

}
