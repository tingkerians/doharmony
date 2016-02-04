//
//  RecordViewController.swift
//  doharmony
//
//  Created by kimpoy on 2/1/16.
//  Copyright © 2016 khemer sone andres. All rights reserved.
//

import UIKit

class RecordViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var yourMusicCV: UICollectionView!
    
    let appleProducts = ["My first Video1","Video2","Video3","Video4","Video5","Video6"]
    
    let imageArray = [UIImage(named: "maxresdefault"), UIImage(named: "maxresdefault-2"),UIImage(named: "maxresdefault"), UIImage(named: "maxresdefault-2"),UIImage(named: "maxresdefault"), UIImage(named: "maxresdefault-2")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.appleProducts.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CollectionViewCell
        
        cell.imageView?.image = self.imageArray[indexPath.row]
        cell.titleLabel?.text = self.appleProducts[indexPath.row]
        
        return cell
    }
    
    
//    func yourMusicCV(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
  //      return self.appleProducts.count
  //  }
    
   // func yourMusicCV(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
     //   let cell = collectionView.dequeueReusableCellWithReuseIdentifier("yourMusicCell", forIndexPath: indexPath) as! CollectionViewCell
        
    //    cell.imageView?.image = self.imageArray[indexPath.row]
    //    cell.titleLabel?.text = self.appleProducts[indexPath.row]
        
   //     return cell
  //  }
   
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showImage", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showImage"
        {
            let indexPaths = self.collectionView!.indexPathsForSelectedItems()!
            let indexPath = indexPaths[0] as NSIndexPath
            
            let vc = segue.destinationViewController as! NewViewController
            
            vc.image = self.imageArray[indexPath.row]!
            vc.title = self.appleProducts[indexPath.row]
        }
    }
    
}
