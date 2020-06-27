//
//  ViewController.swift
//  rps
//
//  Created by Sensehack on 04/10/16.
//  Copyright © 2016 Sensehack. All rights reserved.
//

import UIKit

class RPSViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var rps1 = 0
    
    
    

    @IBAction func scissorsButton() {
        rps1 = 1
        var controller: ResultGameScreen
        
        controller = self.storyboard?.instantiateViewController(withIdentifier: "ResultGameScreen") as! ResultGameScreen
        controller.userPlay  = rps1
        
        //controller.randomRPSPlay = self.randomRPSValue()
        present(controller, animated: true, completion: nil)
        
    }
  
    @IBAction func paperButton() {
        rps1 = 3
        performSegue(withIdentifier: "play", sender: rps1)
        
    }
    
       override func prepare(for segue: UIStoryboardSegue, sender: Any?)
        {
            if segue.identifier == "play" {
                let controller = segue.destination as! ResultGameScreen
                if rps1 == 0 {
                    controller.userPlay = 2
                }
                controller.userPlay = 3
            }
        }
    
}

