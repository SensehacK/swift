//
//  VillainCollectionViewController.swift
//  BondVillains
//
//  Created by Sensehack on 19/10/16.
//  Copyright © 2016 Udacity. All rights reserved.
//

import Foundation
import UIKit

class VillainCollectionViewController : UICollectionViewController {
    
    
    
    let allVillains = Villain.allVillains
    
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allVillains.count
        
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("VillainCollectionViewCell", forIndexPath: indexPath) as! VillainCollectionViewCell
        
        let villain = allVillains[indexPath.row]
        
        
        //set the name / image of CollectionViewCell
        
        cell.collectionTextLabel.text = villain.name
        cell.collectionImageView.image = UIImage(named: villain.imageName)
        
        return cell
    }
    
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("VillainDetailViewController") as! VillainDetailViewController
        
        detailController.villain  = self.allVillains[indexPath.row]
        self.navigationController!.pushViewController(detailController, animated: true)
    }
    
}
