//
//  ViewController.swift
//  CollectionViewR
//
//  Created by Kautilya on 08/04/17.
//  Copyright © 2017 Kautilya. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController {

    var collArray = [String] ()
    var buttArray = [String] ()
    var buttonSelected = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        collArray = ["asfjuner" ,"afjip3","asx3353adf","asfnsete","as335er" ,"afjvnj3","dsg45","34","435j346" ,"afjwevnj3","asxaghibadf","463te"]
        
        buttArray = ["asfjuner" ,"afjip3","asx3353adf","asfnsete","as335er" ,"afjvnj3","dsg45","34","435j346" ,"afjwevnj3","asxaghibadf","463te","7yhj"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 7
        return collArray.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath)  as UICollectionViewCell
        
        
        let label = cell.viewWithTag(1) as! UILabel
        label.text = collArray[indexPath.row]
        
        let button = cell.viewWithTag(2) as! UIButton
//        button.titleLabel?.text = buttArray[indexPath.row]
        
        button.setTitle(buttArray[indexPath.row], for: .normal)
        
        
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("/////////////")
        print(indexPath)
        print(indexPath.row)
        print(buttArray[indexPath.row])
        buttonSelected = buttArray[indexPath.row] as String
        
        performSegue(withIdentifier: "buttonSegue", sender: self)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let segueObject = segue.destination as! SegueViewController
        segueObject.buttonText = buttonSelected
    }
    
    
}

