//
//  VillainDetailViewController.swift
//  BondVillains
//
//  Created by Sensehack on 18/10/16.
//  Copyright © 2016 Udacity. All rights reserved.
//

import Foundation
import UIKit

class VillainDetailViewController : UIViewController {
    
    
    var villain : Villain!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.label.text = self.villain.name
        self.imageView!.image = UIImage(named: villain.imageName)
    }
    
    
    
}
