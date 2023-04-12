//
//  secondGameScreen.swift
//  rps
//
//  Created by Sensehack on 04/10/16.
//  Copyright © 2016 Sensehack. All rights reserved.
//

import Foundation
import UIKit

class ResultGameScreen : UIViewController {
    var randomRPSPlay = 0
    var userPlay: Int?
    var userP = 0
    
    
    @IBOutlet weak var resultImage: UIImageView!
    
    @IBAction func playAgain() {
        // dismiss this view controller
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var resultGameLabel: UILabel!
    
    
    func randomRPSValue() -> Int {
        // generate a random Int32 using arc4Random
        let randomValue = 1 + arc4random() % 3
        // return a more convenient Int, initialized with the random value
        return Int(randomValue)
    }
    
    override func viewWillAppear(_ animated: Bool)
    
    {
    
    
  
        super.viewWillAppear(animated)
        userP = userPlay!
        randomRPSPlay = randomRPSValue()
    
    
        
        
    switch (userP)
        {
        
        case 1: //Scissors
            if (randomRPSPlay == 3)
            {
                resultImage.image  = #imageLiteral(resourceName: "RockCrushesScissors")
                resultGameLabel.text = "Rock Crushes Scissors"
            }
            else
            {
                    if (randomRPSPlay == 2)
                    {
                    resultImage.image  = #imageLiteral(resourceName: "ScissorsCutPaper")
                        resultGameLabel.text = "Scissors Cuts Paper"
                    }
                else {
                    resultImage.image  = #imageLiteral(resourceName: "itsATie")
                        resultGameLabel.text = "Its a Tie"
                    }
            }
        
        
    case 2:  //Paper
        if (randomRPSPlay == 3)
        {
            resultImage.image  = #imageLiteral(resourceName: "PaperCoversRock")
            resultGameLabel.text = "Paper Covers Rock"
        }
        else
        {
            if (randomRPSPlay == 1)
            {
                resultImage.image  = #imageLiteral(resourceName: "ScissorsCutPaper")
                resultGameLabel.text = "Scissors Cuts Paper"
            }
            else {
                resultImage.image  = #imageLiteral(resourceName: "itsATie")
                resultGameLabel.text = "Its a Tie"
            }
        }

    case 3:  //Rock
        if (randomRPSPlay == 1)
        {
            resultImage.image  = #imageLiteral(resourceName: "RockCrushesScissors")
            resultGameLabel.text = "Rock Crushes Scissors"
        }
        else
        {
            if (randomRPSPlay == 2)
            {
                resultImage.image  = #imageLiteral(resourceName: "PaperCoversRock")
                resultGameLabel.text = "Paper Covers Rock"
                
            }
            else {
                resultImage.image  = #imageLiteral(resourceName: "itsATie")
                resultGameLabel.text = "Its a Tie"
            }
        }

        
        default:
        print("Rock Paper Scissors")

        
        } // switch ends
    
    
    
    
    
    
    
        }  // view did load function paranthesis
    
    
    
    
    
}  //class ends
