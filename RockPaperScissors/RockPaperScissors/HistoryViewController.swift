//
//  HistoryViewController.swift
//  RockPaperScissors
//
//  Created by Sensehack on 14/10/16.
//  Copyright © 2016 Gabrielle Miller-Messner. All rights reserved.
//

import Foundation
import UIKit

class HistoryViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Properties
    
    var history: [RPSMatch]!
    
    // MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Table View Delegate
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return history.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let CellID = "HistoryCell"
    
    let cell = tableView.dequeueReusableCellWithIdentifier(CellID, forIndexPath: indexPath)
    
    let match = self.history[indexPath.row]
    
    cell.textLabel!.text = victoryStatusDescription(match)
    cell.detailTextLabel!.text = "\(match.p1) vs. \(match.p2)"
    
    
    return cell
    }
    
    // MARK: Victory Status
    
    func victoryStatusDescription(match: RPSMatch) -> String {
    
    if (match.p1 == match.p2) {
    return "Tie."
    } else if (match.p1.defeats(match.p2)) {
    return "Win!"
    } else {
    return "Loss."
    }
    }
    
    // MARK: Actions
    
    @IBAction func dismissHistory(sender: AnyObject) {
    self.dismissViewControllerAnimated(true, completion: nil)
    }

    
    @IBAction func dismissHistory2(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
}
