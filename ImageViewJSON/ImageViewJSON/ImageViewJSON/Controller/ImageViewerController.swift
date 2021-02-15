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
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollImageView: UIImageView!
    
    
    
    var response: Response?
    var selectedImageCollection: Int?
    var responseArrayCount: Int?
    var imgObjArray = [ImageResponse]()
    var allocatedViews: [UIView] = [UIView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup(selectCollection: selectedImageCollection ?? 0)
        responseArrayCount = response?.manifest.count ?? 0
//        imageLabel.text  = imgResponse?.name
//        imageView.image = imgResponse?.url
    }
    
    
    func setup(selectCollection: Int) {
        
        backButton.isEnabled = false
        nextButton.isEnabled = false
        nextButton.isHidden = true
        backButton.isHidden = true
        
        
        print("selectCollection Array selected Before: \(selectCollection)")
        guard let imageValue = response?.manifest[selectCollection] else { return }
        print("ImgObjArray Before: \(self.imgObjArray.count)")
        print("imageValue Before: \(imageValue.count)")
        var imageDisplayedCount = 0
        for i in 0..<imageValue.count {
            retrieveImage(value: imageValue[i]) { (response) in
                print("Network response callback : \(i) ##### ")
                print("Response name: \(response.name)")
                print("Response URL: \(response.url)")
                self.imgObjArray.append(response)
                /// The logic fails if in asynchronous network call arr[0,1] => arr[1] returns first so directly comparing ith element == images.count doesn't cut it and we have to resort to maintaining our own counter
                imageDisplayedCount += 1
                // Checking whether its at the last element of JSON data
                if (imageValue.count == imageDisplayedCount) {
                    self.uiViewSetup()
                }
//                self.imageLabel.text = response.name
//                self.imageView.downloaded(from: response.url, contentMode: .scaleToFill)
                
                
                //            self.imageView.downloadImage(from: response.url)
    //            self.imageView.downloaded(from: response.url)
                //            imageView.image = response.url
            }
        }
        
        
        
    }
    
    
    // Setting up scroll view
    func uiViewSetup() {
        let imagesCount = imgObjArray.count
        print("ImgObjArray after: \(imgObjArray.count)")
        let colors: [UIColor] = [.red, .blue, .green]
        
        // Scroll view init options
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: view.frame.size.width * CGFloat(imagesCount) , height: scrollView.frame.size.height)
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        /// Bug fix
        // One more bug resolved: When making image scrolled from [0: [0],1:[0,1], 2:[0,1,2]]
        // arr[1:[1]] -=> arr[2:[1]] It waas directly moving to 2nd element rather moving to arr[2:[0]]
        scrollView.setContentOffset(CGPoint(x: CGFloat(0) * view.frame.size.width, y: 0), animated: true)
        
        // Page Control init options
        pageControl.numberOfPages = imagesCount
        pageControl.addTarget(self, action: #selector(pageControlDidChange), for: .valueChanged)
        
        
        
        for i in 0..<imagesCount {
            let UIImagePage = UIView(frame: CGRect(x: CGFloat(i) * view.frame.size.width, y: 0, width: view.frame.size.width, height: scrollView.frame.size.height))

//            UIImagePage.backgroundColor = colors[i]
//            let imageData = data
            print("view.frame.size.width: \(view.frame.size.width)")
            print("X calculations:  \((CGFloat(i) * view.frame.size.width) + 20)")
            print("UIImagePage calculations: \(UIImagePage.frame.origin.x + 20)")
            let imageView = UIImageView(frame: CGRect(x: UIImagePage.frame.origin.x + 20, y: 50, width: 300, height: 169))
//            imageView.center = self.scrollView.center
            imageView.center = self.scrollView.center
            imageView.frame.origin.y = 50
            print(" Center yourself \(self.scrollView.centerXAnchor)")
            print("Images Count: \(i)")
            print("Image URL: \(imgObjArray[i])")
            imageView.downloaded(from: imgObjArray[i].url, contentMode: .scaleToFill)
            
//            scrollView.addSubview(imageView)
            
            
            scrollView.addSubview(UIImagePage)
            UIImagePage.addSubview(imageView)
            allocatedViews.append(UIImagePage)
            
            
        }
        //TODO: Look here for next or prev scenarios
        print("Values Selected ####### : \(selectedImageCollection) : Overall Response count \(responseArrayCount! - 1)")
        if (selectedImageCollection! < responseArrayCount! - 1) {
            nextButton.isHidden = false
            nextButton.isEnabled = true
        }
        
        if (selectedImageCollection! > 0) {
            backButton.isHidden = false
            backButton.isEnabled = true
        }
        
//        if (imagesCount > 0) {
//            nextButton.isHidden = !nextButton.isHidden
//            nextButton.isEnabled = !nextButton.isEnabled
//        } else {
//            nextButton.isEnabled = !nextButton.isEnabled
//            nextButton.isHidden = !nextButton.isHidden
//        }
            

        let currentImage = imgObjArray[0]
        self.imageLabel.text = currentImage.name
//        self.imageView.downloaded(from: currentImage.url, contentMode: .scaleToFill)
    }
    
    @objc private func pageControlDidChange(_ sender: UIPageControl) {
        let current = sender.currentPage
        print("PageControlDidChange: %%%%%%  +\(current)")
        scrollView.setContentOffset(CGPoint(x: CGFloat(current) * view.frame.size.width, y: 0), animated: true)
    }
    
    @IBAction func nextBtnPressed(_ sender: Any) {
        // Removing UIViews added to the Viewport programmatically.
        for view in allocatedViews {
            view.removeFromSuperview()
//            view = nil
        }
//        scrollView.removeFromSuperview()
//        scrollView = nil
        
        pageControl.currentPage = 0
        print("Calling nextBtnPressed +\(nextButton.isEnabled)")
        print(selectedImageCollection)
        print(responseArrayCount! - 1)
        if (selectedImageCollection! < responseArrayCount! - 1) {
            selectedImageCollection! += 1
            imgObjArray.removeAll()
            allocatedViews.removeAll()
            print("Calling next button full functions @@@@@@@@@@")
            setup(selectCollection: selectedImageCollection!)
        } else {
            nextButton.isEnabled = !nextButton.isEnabled
        }
        
        if (selectedImageCollection! > 0) {
            backButton.isHidden = false
            backButton.isEnabled = true
        }
        
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        // Removing UIViews added to the Viewport programmatically.
        for view in allocatedViews {
            view.removeFromSuperview()
//            view = nil
        }
//        scrollView.removeFromSuperview()
//        scrollView = nil
        pageControl.currentPage = 0
        print("Calling backBtnPressed +\(backButton.isEnabled)")
        print(selectedImageCollection)
        
//        for view in self.scrollView.subviews {
//            if (view.isKind(of: UIView.self) || view.isKind(of: UIImageView.self)) {
//                view.removeFromSuperview()
//            }
//        }
        
        if (selectedImageCollection! > 0) {
            selectedImageCollection! -= 1
            imgObjArray.removeAll()
            allocatedViews.removeAll()
//            for (UIView *view in self.contentView.subviews)
//            {
//                if (![view isKindOfClass:[UIImageView class]])
//                    [view removeFromSuperview];
//            }
            //
            print("Calling back button full functions @@@@@@@@@")
            setup(selectCollection: selectedImageCollection!)
        } else {
            backButton.isEnabled = false
            
        }
        
        if (selectedImageCollection! < responseArrayCount! - 1) {
            nextButton.isEnabled = true
        }
        
        
    }
    
    
    private func retrieveImage(value: String, completionHandler: @escaping (ImageResponse) -> Void){
        var imgResponse: ImageResponse?
        
        guard let url = URL(string: Constants.baseURL.rawValue + Constants.image.rawValue + value) else { return  }
        print("URL Retrieving image +\(url)")
        // ImageResponse(name: "Billy", url: "https://i.redd.it/vxyig96zgfh61.png", type: "png", width: 400, height: 400)
        // Creating URL Request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // Setting API Key
        request.setValue(Constants.apiKey.rawValue, forHTTPHeaderField: Constants.apiHeader.rawValue)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else { return }
            
            
            guard let httpResponse = (response as? HTTPURLResponse)?.statusCode, httpResponse == HTTPStatusCode.statusSuccess.rawValue else {
                let httpCode = (response as? HTTPURLResponse )?.statusCode
                print("Error in retrieving data from API", +httpCode!)
                if httpCode == HTTPStatusCode.statusUnauthorized.rawValue {
                    print(Connection.statusUnauthorized.rawValue)
                }
                DispatchQueue.main.async {
                    // TODO: Create a small popup alert stating error in retrieving data so the user is informed with the process.
                }
                return
            }
            
            
            guard let data = data else { return }
            do {
                imgResponse = try JSONDecoder().decode(ImageResponse.self, from: data)
                guard let imgResponse = imgResponse else {
                    return
                }
                print(imgResponse.name)
                print(imgResponse.url)
//                return imgResponse
                DispatchQueue.main.async {
                    completionHandler(imgResponse)
//                    return imgResponse
                }
            } catch let error {
                print("Error in retrieving data" + error.localizedDescription)
            }
            
            
        }

        // Resume Asynchronous network call
        task.resume()
        
//        return imgResponse!
    }


}


// MARK: - UITableViewDelegate Methods
extension ImageViewerController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let calculatedPage = Int(floorf(Float(scrollView.contentOffset.x / scrollView.frame.size.width)))
        pageControl.currentPage = calculatedPage
        print("Scroll View calculated Page :\(calculatedPage)")
        if calculatedPage >= 0 {
            self.imageLabel.text = imgObjArray[calculatedPage].name
        } else {
            print("Page went to Negative")
        }
        
        // This initialization made the code break mostly.
//        selectedImageCollection = calculatedPage
    }
    
}

