//
//  MyCollectionViewCell.swift
//  DogsCollectionView
//
//  Created by Sensehack on 3/26/21.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var imageName: UILabel!
    @IBOutlet var imageDate: UILabel!
    
    static let identifier = "MyCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func configure(with image: String, name: String, date: String) {
        imageView.downloaded(from: image)
        imageName.text = name
        imageDate.text? = date.formatDateString(dateString: date)
        imageDate.text = date
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "MyCollectionViewCell", bundle: nil)
    }
    
    
    

}
