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
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollImageView: UIImageView!
    
    
    
    var response: Response?
    var selectedImageCollection: Int = 0
    var imgResponse: ImageResponse?
    var imgObjArray = [ImageResponse]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
        imageLabel.text  = imgResponse?.name
//        imageView.image = imgResponse?.url
    }
    
    
    func setup() {
        
        guard let imageValue = response?.manifest[selectedImageCollection]  else { return }
        
        for i in 0..<imageValue.count {
            retrieveImage(value: imageValue[i]) { (response) in
                print("Network response callback #####")
                print("Response name: \(response.name)")
                print("Response URL: \(response.url)")
                self.imgObjArray.append(response)
                if (imageValue.count-1 == i) {
                    self.scrollViewSetup()
                }
//                self.imageLabel.text = response.name
//                self.imageView.downloaded(from: response.url, contentMode: .scaleToFill)
                
                
                //            self.imageView.downloadImage(from: response.url)
    //            self.imageView.downloaded(from: response.url)
                //            imageView.image = response.url
            }
        }
        
        
    }
    
    
    func scrollViewSetup() {
        let imagesCount = imgObjArray.count
        scrollView.contentSize = CGSize(width: view.frame.size.width * CGFloat(imagesCount) , height: scrollView.frame.size.height)
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        pageControl.numberOfPages = imagesCount
        let colors: [UIColor] = [.red, .blue, .green]
        
        for i in 0..<imagesCount {
//            let UIImagePage = UIView(frame: CGRect(x: CGFloat(i) * view.frame.size.width, y: 0, width: view.frame.size.width, height: scrollView.frame.size.height))
//
//            UIImagePage.backgroundColor = colors[i]
//            let imageData = data
            print("view.frame.size.width: \(view.frame.size.width)")
            print("X calculations:  \((CGFloat(i) * view.frame.size.width) + 20)")
            let imageView = UIImageView(frame: CGRect(x: (CGFloat(i) * view.frame.size.width) + 20, y: 50, width: 160, height: 90))
            print("Images Count: \(i)")
            print("Image URL: \(imgObjArray[i])")
            imageView.downloaded(from: imgObjArray[i].url, contentMode: .scaleToFill)
            scrollView.addSubview(imageView)
            
//            scrollView.addSubview(UIImagePage)
//            UIImagePage.addSubview(imageView)
            
        }
        
        
        
        let currentImage = imgObjArray[0]
        self.imageLabel.text = currentImage.name
//        self.imageView.downloaded(from: currentImage.url, contentMode: .scaleToFill)
    }
    
    private func retrieveImage(value: String, completionHandler: @escaping (ImageResponse) -> Void){
        var imgResponse: ImageResponse?
        
        guard let url = URL(string: Constants.baseURL.rawValue + Constants.image.rawValue + value) else { return  }
        
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

