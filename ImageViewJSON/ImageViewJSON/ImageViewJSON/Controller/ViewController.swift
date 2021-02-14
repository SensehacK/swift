//
//  ViewController.swift
//  ImageViewJSON
//
//  Created by Sensehack on 2/13/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var connectButton: UIButton!
    @IBOutlet weak var resultsTable: UITableView!
    @IBOutlet weak var statusLabel: UILabel!
    
    
    var response: Response?
    var count = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.statusLabel.isHidden = true
        resultsTable.delegate = self
        resultsTable.dataSource = self
    }
    
    
    @IBAction func connectBtnPressed(_ sender: Any) {
        print("Hello Sensehack!")
        retrieveData {
            self.resultsTable.reloadData()
        }
    }
    
    
    
    private func retrieveData(completed: @escaping () -> ()) {
        
        guard let url = URL(string: Constants.baseURL.rawValue + Constants.manifest.rawValue) else { return }
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
                    self.statusLabel.text = Connection.errorConnecting.rawValue
                    self.statusLabel.isHidden = false
                    // TODO: Create a small popup alert stating error in retrieving data so the user is informed with the process.
                }
                return
            }
            
            
            guard let data = data else { return }
            do {
                self.response = try JSONDecoder().decode(Response.self, from: data)
//                print(json.response)
//                self.response = json
//                print(json.response.count)
//                print(self.response.count)
                guard let response = self.response else {
                    return
                }
                print(response.manifest.count)
                print(response.manifest[0])
//                print(self.manifest[0])
                DispatchQueue.main.async {
                    completed()
//                    self.programmerAuthor.isHidden = false
//                    self.programmerQuote.text = json.en!
//                    self.programmerAuthor.text = "-\(json.author!)"
                }
            } catch let error {
                print("Error in retrieving data" + error.localizedDescription)
            }
        }

        // Resume Asynchronous network call
        task.resume()
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
                    self.statusLabel.text = Connection.errorConnecting.rawValue
                    self.statusLabel.isHidden = false
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ImageViewerController {
            destination.response = response
            destination.selectedImageCollection = resultsTable.indexPathForSelectedRow?.row ?? 0
//            let input = response?.manifest[resultsTable.indexPathForSelectedRow?.row ?? 0]
//            guard let imageValue = input?.first else { return }
//            retrieveImage(value: imageValue) { (response) in
//                destination.imgResponse = response
//            }
//            destination.imgResponse = retrieveImage(value: (input?[0])!)
        }
    }


}


// MARK: - UITableViewDataSource Methods
extension ViewController: UITableViewDataSource {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return response?.manifest.count ?? 0
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = response?.manifest[indexPath.row].joined(separator: ", ")
        return cell
    }

}

// MARK: - UITableViewDelegate Methods
extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.imageViewSegue.rawValue, sender: self)
    }
}

