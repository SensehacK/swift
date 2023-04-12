//
//  ViewController.swift
//  TableViewDelete
//
//  Created by Kautilya on 03/04/17.
//  Copyright © 2017 Kautilya. All rights reserved.
//

import UIKit


class ViewController: UIViewController  , UITableViewDelegate , UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    
    
    var superheroes = ["Spiderman","Superman","IronMan" ,"Hulk","Captain America","AntMan","Batman"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return superheroes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        print("Hello cell for row at")
        print(indexPath.row)
        
        cell.textLabel?.text = superheroes[indexPath.row]
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("row selected by user")
        performSegue(withIdentifier: "sendHeroName", sender: superheroes[indexPath.row])
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let segueObject = segue.destination as! SegueViewController
        segueObject.segueString = sender as! String
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        print("Hello Editing")
        
        if editingStyle == .delete {
            superheroes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
        
        
    }
    
}

