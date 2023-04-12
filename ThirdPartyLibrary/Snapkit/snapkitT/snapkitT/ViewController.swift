//
//  ViewController.swift
//  snapkitT
//
//  Created by Sensehack on 7/1/20.
//  Copyright © 2020 Sensehack. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    
    var yellowBox = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = .white
        // Do any additional setup after loading the view.
        setupViews()
        //runSwiftAutoLayout()
        snapKitLayout()
    }

    
    private func setupViews() {
        print("In Setup views")
        yellowBox.backgroundColor = .yellow
        //yellowBox.translatesAutoresizingMaskIntoConstraints = false;
        self.view.addSubview(yellowBox)
    }
    
    
    private func runSwiftAutoLayout() {
        yellowBox.widthAnchor.constraint(equalToConstant: 80).isActive = true
        yellowBox.heightAnchor.constraint(equalToConstant: 80).isActive = true
        yellowBox.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        yellowBox.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    
    
    
    private func snapKitLayout() {
        
        yellowBox.snp.makeConstraints { (make) in
            make.width.equalTo(90)
            make.height.equalTo(120)
            make.center.equalTo(view.snp.center)
            
        }
    }

}

