//
//  ImageViewerController.swift
//  ImageViewJSON
//
//  Created by Sensehack on 2/13/21.
//

import UIKit

class ImageViewerController: UIViewController {

    @IBOutlet weak var imageLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!


    var response: Response?
    var selectedImageCollection: Int?
    var responseArrayCount: Int?
    var imgObjArray = [ImageResponse]()
    var allocatedViews: [UIView] = [UIView]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup(selectCollection: selectedImageCollection ?? 0)
        responseArrayCount = response?.manifest.count ?? 0
    }
    
    
    func setup(selectCollection: Int) {
        // Initial button behavior
        backButton.isEnabled = false
        nextButton.isEnabled = false
        nextButton.isHidden = true
        backButton.isHidden = true

        var imageDisplayedCount = 0
        guard let imageValue = response?.manifest[selectCollection] else { return }

        for i in 0..<imageValue.count {
            retrieveImage(value: imageValue[i]) { (response) in
                ///print("Network response callback : ##### \(i)Response name: \(response.name) Response URL: \(response.url)"")
                self.imgObjArray.append(response)

                /// The logic fails if in asynchronous network call arr[0,1] => arr[1] returns first so directly comparing ith element == images.count doesn't cut it and we have to resort to maintaining our own counter
                imageDisplayedCount += 1
                // Checking whether its at the last element of JSON data
                if (imageValue.count == imageDisplayedCount) {
                    self.uiViewSetup()
                }
            }
        }
    }
    
    
    // Setting up scroll view
    func uiViewSetup() {
        let imagesCount = imgObjArray.count

        // Scroll view init options
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: view.frame.size.width * CGFloat(imagesCount) , height: scrollView.frame.size.height)
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false

        // Bug fix
        /// One more bug resolved: When making image scrolled from [0: [0],1:[0,1], 2:[0,1,2]]
        /// arr[1:[1]] -=> arr[2:[1]] It waas directly moving to 2nd element rather moving to arr[2:[0]]
        scrollView.setContentOffset(CGPoint(x: CGFloat(0) * view.frame.size.width, y: 0), animated: true)

        // Page Control init options
        pageControl.numberOfPages = imagesCount
        pageControl.addTarget(self, action: #selector(pageControlDidChange), for: .valueChanged)

        // Looping through Image objects to create Views
        for i in 0..<imagesCount {
            let UIImagePage = UIView(frame: CGRect(x: CGFloat(i) * view.frame.size.width, y: 0, width: view.frame.size.width, height: scrollView.frame.size.height))
            let imageView = UIImageView(frame: CGRect(x: UIImagePage.frame.origin.x, y: CGFloat(Sizes.imageViewYCoordinate.rawValue), width: CGFloat(Sizes.imageViewWidth.rawValue), height: CGFloat(Sizes.imageViewHeight.rawValue)))
            imageView.center = self.scrollView.center
            imageView.frame.origin.y = CGFloat(Sizes.imageViewYCoordinate.rawValue)
            imageView.downloaded(from: imgObjArray[i].url, contentMode: .scaleToFill)

            scrollView.addSubview(UIImagePage)
            UIImagePage.addSubview(imageView)
            allocatedViews.append(UIImagePage)

        }

        //Debug for next or prev scenarios
        ///print("Values Selected ####### : \(selectedImageCollection) : Overall Response count \(responseArrayCount! - 1)")
        if (selectedImageCollection! < responseArrayCount! - 1) {
            nextButton.isHidden = false
            nextButton.isEnabled = true
        }

        if (selectedImageCollection! > 0) {
            backButton.isHidden = false
            backButton.isEnabled = true
        }

        let currentImage = imgObjArray.first
        self.imageLabel.text = currentImage?.name ?? "No response from server"
    }
    
    @objc private func pageControlDidChange(_ sender: UIPageControl) {
        let current = sender.currentPage
        scrollView.setContentOffset(CGPoint(x: CGFloat(current) * view.frame.size.width, y: 0), animated: true)
    }

    @IBAction func nextBtnPressed(_ sender: Any) {
        if (selectedImageCollection! < responseArrayCount! - 1) {
            selectedImageCollection! += 1
            resetData()
        } else {
            nextButton.isEnabled = false
        }

        if (selectedImageCollection! > 0) {
            backButton.isHidden = false
            backButton.isEnabled = true
        }
        
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        if (selectedImageCollection! > 0) {
            selectedImageCollection! -= 1
            resetData()
        } else {
            backButton.isEnabled = false
        }

        if (selectedImageCollection! < responseArrayCount! - 1) {
            nextButton.isEnabled = true
        }
    }

    private func resetData() {
        imgObjArray.removeAll()
        allocatedViews.removeAll()
        pageControl.currentPage = 0
        // Removing UIViews added to the Viewport programmatically.
        for view in allocatedViews {
            view.removeFromSuperview()
        }
        setup(selectCollection: selectedImageCollection!)
    }
    
    private func retrieveImage(value: String, completionHandler: @escaping (ImageResponse) -> Void){
        var imgResponse: ImageResponse?
        
        guard let url = URL(string: Constants.baseURL.rawValue + Constants.image.rawValue + value) else { return  }
        print("URL Retrieving image: \(url)")
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
                ///print("Image Details:  \(imgResponse.name) \(imgResponse.url) ")
                DispatchQueue.main.async {
                    completionHandler(imgResponse)
                }
            } catch let error {
                print("Error in retrieving data" + error.localizedDescription)
            }

        }

        // Resume Asynchronous network call
        task.resume()
    }


}


// MARK: - UITableViewDelegate Methods
extension ImageViewerController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let calculatedPage = Int(floorf(Float(scrollView.contentOffset.x / scrollView.frame.size.width)))
        pageControl.currentPage = calculatedPage
        // Updating the proper text by calculated page
        if calculatedPage >= 0 {
            self.imageLabel.text = imgObjArray[calculatedPage].name
        } else {
            print("Page went to Negative")
        }

        /// This initialization made the code break mostly leading differently when enabling and disabling navigation buttons
        ///selectedImageCollection = calculatedPage
    }
}

