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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.statusLabel.isHidden = true
        resultsTable.delegate = self
        resultsTable.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.resultsTable.deselectSelectedRow(animated: true)
    }

    @IBAction func connectBtnPressed(_ sender: Any) {
        retrieveData { self.resultsTable.reloadData() }
    }

    // Connecting with API, making a network request and populating the object to variable response.
    private func retrieveData(completed: @escaping () -> ()) {
        guard let url = URL(string: AppConstants.baseURL + Constants.manifest.rawValue) else { return }
        // Creating URL Request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // Setting API Key
        request.setValue(AppConstants.apiKey, forHTTPHeaderField: AppConstants.apiHeader)
        
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
                guard self.response != nil else { return }

                DispatchQueue.main.async {
                    completed()
                }
            } catch let error {
                print("Error in retrieving data" + error.localizedDescription)
            }
        }

        // Resume Asynchronous network call
        task.resume()
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ImageViewerController {
            destination.response = response
            destination.selectedImageCollection = resultsTable.indexPathForSelectedRow?.row ?? 0
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

