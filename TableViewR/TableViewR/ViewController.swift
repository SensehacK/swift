//
//  ViewController.swift
//  TableViewR
//
//  Created by Kautilya on 03/04/17.
//  Copyright © 2017 Kautilya. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    let grocery_list = ["Milk","Honey","Biscuit","Sugar"]
    
    var fruits_list = ["Apple", "Pineapple", "Orange", "Blackberry", "Banana", "Pear", "Kiwi", "Strawberry", "Mango", "Walnut", "Apricot", "Tomato", "Almond", "Date", "Melon", "Water Melon", "Lemon", "Coconut", "Fig", "Passionfruit", "Star Fruit", "Clementin", "Citron", "Cherry", "Cranberry"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return (fruits_list.count)
//        return 5
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell  = UITableViewCell(style: .default, reuseIdentifier: "cell")
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell2.textLabel?.text = fruits_list[indexPath.row]
        
        cell.textLabel?.text = fruits_list[indexPath.row]
        
        return (cell2)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

