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
    var selectedImageCollection: Int = 0
    var imgResponse: ImageResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
        imageLabel.text  = imgResponse?.name
//        imageView.image = imgResponse?.url
    }
    
    
    func setup() {
        
        guard let imageValue = response?.manifest[selectedImageCollection].first  else { return }

        retrieveImage(value: imageValue) { (response) in
            print("Network response callback #####")
            self.imageLabel.text = response.name
//            self.imageView.downloadImage(from: response.url)
            print("Response URL: \(response.url)")
            self.imageView.downloaded(from: response.url, contentMode: .scaleToFill)
//            self.imageView.downloaded(from: response.url)
            //            imageView.image = response.url
        }
        
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

