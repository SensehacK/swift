//
//  ImageViewerController.swift
//  ImageViewJSON
//
//  Created by Sensehack on 2/13/21.
//

import UIKit

class ImageViewerController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!
    
    var response: Response?
    var imgArray: Int = 0
    var imgResponse: ImageResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        imageLabel.text  = imgResponse?.name
//        imageView.image = imgResponse?.url
    }
    
    
    


}

