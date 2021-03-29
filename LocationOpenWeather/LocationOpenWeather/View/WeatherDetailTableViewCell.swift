//
//  WeatherDetailTableViewCell.swift
//  LocationOpenWeather
//
//  Created by Sensehack on 3/8/21.
//

import UIKit

class WeatherDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var firstStack: UIStackView!
    @IBOutlet weak var secondStack: UIStackView!
    @IBOutlet weak var thirdStack: UIStackView!
    
    @IBOutlet weak var firstStackLabel1: UILabel!
    @IBOutlet weak var firstStackLabel2: UILabel!

    @IBOutlet weak var secondStackLabel1: UILabel!
    @IBOutlet weak var secondStackLabel2: UILabel!
    
    @IBOutlet weak var thirdStackLabel1: UILabel!
    @IBOutlet weak var thirdStackLabel2: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
