//
//  ViewController.swift
//  ColorSlider
//
//  Created by Sensehack on 02/10/16.
//  Copyright © 2016 Sensehack. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var redSlider: UISlider!
    
    @IBOutlet weak var greenSlider: UISlider!
    
    
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var colorView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    @IBAction func chanKautilyaolorComponent(sender: AnyObject) {
        print("Hello next info Redslider values")
        let redF = redSlider.value
        print(redF)
        print("Hello next info Greenslider values")
        let greenF = greenSlider.value
        print(greenF)
        print("Hello next info blueslider values")
        let blueF = blueSlider.value
        print(blueF)
        
        let redCF: CGFloat = CGFloat(redF)
        let greenCF: CGFloat = CGFloat(greenF)
        let blueCF: CGFloat = CGFloat(blueF)
        colorView.backgroundColor = UIColor(red: redCF, green: greenCF, blue: blueCF, alpha: 1)
        
        
        /* let r: CGFloat = self.redSlider.on ? 1 : 0
        let g: CGFloat = self.greenControl.on ? 1 : 0
        let b: CGFloat = self.blueControl.on ? 1 : 0
        
        colorView.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 1)
 
 */
    }


}

