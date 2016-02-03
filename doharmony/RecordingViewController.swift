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
        
        let newTemplate = UIView.init(frame: CGRectMake(10, 10, template.frame.width * 3.7, template.frame.height * 3.7))
        newTemplate.backgroundColor = UIColor.blackColor()
        
        self.view.addSubview(newTemplate)
        
//        let horizontalConstraint = newTemplate.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor, constant: 80)
//        let verticalConstraint = newTemplate.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor)
//        NSLayoutConstraint.activateConstraints([horizontalConstraint])
        
        newTemplate.center = self.view.center
        
        for sv:UIView in template.subviews{
            let x = sv.frame.origin.x * 3.7
            let y = sv.frame.origin.y * 3.7
            let w = sv.frame.width * 3.7
            let h = sv.frame.height * 3.7
            
            let size = CGRectMake(x, y, w, h)
            let frame:UIView = UIView.init(frame: size)
            frame.backgroundColor = UIColor.lightGrayColor()    
            
            newTemplate.addSubview(frame)
        }
    }

//    var Template:UIView!
//    var Frames = [UIView]()
//    var newTemplate:UIView!
//    
//    override func viewDidLoad() {
//        dupe()
//    }
//    
//    func dupe(){
//        if(newTemplate !== nil){
//            newTemplate.removeFromSuperview()
//        }
//        newTemplate = UIView.init(frame: CGRectMake(10, 10, Template.frame.width * 2, Template.frame.height * 2))
//        newTemplate.backgroundColor = UIColor.blackColor()
//        self.view.addSubview(newTemplate)
//        newTemplate.center = self.view.center
//        //
//        for(var index = 0 ; index < Frames.count ; index++){
//            let x = Frames[index].frame.origin.x * 2
//            let y = Frames[index].frame.origin.y * 2
//            let w = Frames[index].frame.width * 2
//            let h = Frames[index].frame.height * 2
//            
//            let size = CGRectMake(x, y, w, h)
//            let frame:UIView = UIView.init(frame: size)
//            frame.backgroundColor = UIColor.whiteColor()
//            
//            newTemplate.addSubview(frame)
//        }
//    }

}
