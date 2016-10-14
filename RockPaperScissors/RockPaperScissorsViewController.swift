//
//  RockPaperScissorsViewController.swift
//  RockPaperScissors
//
//  Created by Gabrielle Miller-Messner on 10/30/14.
//  Copyright (c) 2014 Gabrielle Miller-Messner. All rights reserved.
//

import UIKit

// MARK: - RockPaperScissorsViewController: UIViewController

class RockPaperScissorsViewController: UIViewController {

    // MARK: Properties
    
    
    
    // Here is the history array which will hold the results of each match that is played in a session.
    
    var history = [RPSMatch]()
    
    // MARK: Outlets
    
    @IBOutlet weak var rockButton: UIButton!
    @IBOutlet weak var paperButton: UIButton!
    @IBOutlet weak var scissorsButton: UIButton!
    
    // MARK: Actions
    
    @IBAction func makeYourMove(sender: UIButton) {
        
        // The RPS enum holds a player's move
        switch (sender) {
        case self.rockButton:
            throwDown(RPS.Rock)
            
        case self.paperButton:
            throwDown(RPS.Paper)

        case self.scissorsButton:
            throwDown(RPS.Scissors)
        
        default:
            assert(false, "An unknown button is invoking makeYourMove()")
        }
    }
    
    @IBAction func showHistory(sender: AnyObject) {
        //TODO: Present HistoryViewController
        
        let storyboard = self.storyboard
        let controller = storyboard!.instantiateViewControllerWithIdentifier("HistoryViewController")as! HistoryViewController
        
        controller.history = self.history
        
        self.presentViewController(controller, animated: true, completion: nil)
    }
    @IBAction func showHistory2(sender: AnyObject) {
        
        let storyboard = self.storyboard
        let controller = storyboard!.instantiateViewControllerWithIdentifier("HistoryViewController")as! HistoryViewController
        
        controller.history = self.history
        
        self.presentViewController(controller, animated: true, completion: nil)
        
    }
    
    // MARK: Play!
    
    func throwDown(playersMove: RPS) {
        // The RPS enum generates the opponent's move
        let computersMove = RPS()
        
        // The RPSMatch struct stores the results of a match
        let match = RPSMatch(p1: playersMove, p2: computersMove)
        
        // Here we add a match to the history array. 
        history.append(match)
        
        //Here are the 3 ways of presenting a View Controller
        
        // 1st Way: Programmatic View Controller Presentation
        
            let storyboard = UIStoryboard (name: "Main", bundle: nil)
            let resultVC = storyboard.instantiateViewControllerWithIdentifier("ResultViewController") as! ResultViewController
        
            // Communicate the match
            resultVC.match = match
            self.presentViewController(resultVC, animated: true, completion: nil)
        
    
    
    }

}
