//
//  HomeViewController.swift
//  doharmony
//
//  Created by kimpoy on 1/26/16.
//  Copyright © 2016 khemer sone andres. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    

        
    @IBOutlet weak var collectionView: UICollectionView!
  
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    let appleProducts = ["My first Video1","Video2","Video3","Video4","Video5","Video6"]
    
    let imageArray = [UIImage(named: "maxresdefault"), UIImage(named: "5"),UIImage(named: "maxresdefault-3"), UIImage(named: "maxresdefault-2"),UIImage(named: "4"), UIImage(named: "maxresdefault-2")]
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
      
//        MainScroll.contentSize.height = 600
//        NewTracksScroll.contentSize.width = 950
//        RecomendedTracksScroll.contentSize.width = 950
//        LatestTracksScroll.contentSize.width = 950
        
//        TapAction()
//        let tap = UITapGestureRecognizer(target: self, action: nil)
//        tap.delegate = self
//        MainScroll.addGestureRecognizer(tap)
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.appleProducts.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! HomeCollectionViewCell
        
        cell.imageView?.image = self.imageArray[indexPath.row]
        cell.titleLabel?.text = self.appleProducts[indexPath.row]
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("toPlayerPage", sender: self)
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toPlayerPage"
        {
            print("toPlayerPage")
            let indexPaths = self.collectionView!.indexPathsForSelectedItems()!
            let indexPath = indexPaths[0] as NSIndexPath
            
            let vc = segue.destinationViewController as! PlayerViewController
            
            vc.image = self.imageArray[indexPath.row]!
            vc.title = self.appleProducts[indexPath.row]
        }
    }

    
//    
//    func TapAction(){
//        print("tap")
//        for temp:UIView in MainScroll.subviews{
//            let tap = UITapGestureRecognizer(target: self, action: Selector("next:"))
//            temp.addGestureRecognizer(tap)
//        }
//    }
//    
//    func next(sender: UITapGestureRecognizer){
//        self.performSegueWithIdentifier("toPlayerPage", sender: sender)
//    }
//    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
////        if segue.identifier == "toPlayerPage" {
////            let playerPage = segue.destinationViewController as! RecordingViewController
////            playerPage.dupe(Template)
////        }
//    }
   
}
