//
//  LayoutPageViewController.swift
//  doharmony
//
//  Created by eleazer on 01/02/2016.
//  Copyright © 2016 khemer sone andres. All rights reserved.
//

import Foundation
import UIKit

class LayoutViewController: UIViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    var pageViewController: UIPageViewController!
    let pages = ["layoutSelection1", "layoutSelection2"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let vc = storyboard?.instantiateViewControllerWithIdentifier("layoutSelectionPageController") {
            self.addChildViewController(vc)
            self.view.addSubview(vc.view)
        
            pageViewController = vc as! UIPageViewController
            pageViewController.dataSource = self
            pageViewController.delegate = self
            
            pageViewController.setViewControllers([viewControllerAtIndex(0)!], direction: .Forward, animated: true, completion: nil)
            pageViewController.didMoveToParentViewController(self)
        }
    }
    
    //MARK: Page View Controller DataSource
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        if let index = pages.indexOf(viewController.restorationIdentifier!) {
            if index > 0 {
                return viewControllerAtIndex(index - 1)
            }
        }
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        if let index = pages.indexOf(viewController.restorationIdentifier!) {
            if index < pages.count - 1 {
                return viewControllerAtIndex(index + 1)
            }
        }
        return nil
    }
    
    func viewControllerAtIndex(index: Int) -> UIViewController? {
        let vc = storyboard?.instantiateViewControllerWithIdentifier(pages[index])
        return vc
    }

}
