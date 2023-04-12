//
//  ViewController.swift
//  LocationOpenWeather
//
//  Created by Sensehack on 3/8/21.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    @IBOutlet weak var resultsTable: UITableView!
    var openWeatherResponse: [OpenWeatherModel]?
    let manager = CLLocationManager()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        view.backgroundColor = .green
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.resultsTable.dataSource = self
        self.resultsTable.delegate = self
//        manager.desiredAccuracy = kCLLocationAccuracyBest
//        manager.delegate = self
//        manager.requestWhenInUseAuthorization()
//        manager.startUpdatingLocation()
        
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        print("Button tapped")
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func getLocationFromDevice(_ location: CLLocation) {
        
        let currLong = location.coordinate.longitude
        let currLat = location.coordinate.latitude
        print("Current location \(currLong)")
        print("Current latitude \(currLat)")
        
        NetworkAPI.sharedInstance().getWeatherDataByLatLon(latitudeWeather : currLat, longitudeWeather: currLong, completionHandler : { [weak self] result in
            
            switch result {
            case .success(let data):
                print("In success block")
                self?.openWeatherResponse?.append(data)
                DispatchQueue.main.async {
                    self?.resultsTable.reloadData()
                }
            case .failure(let error): break
                // Check for internal error enum cases
                print("Some error occured")
            }
            
            
        })
        
    }
    
    func initializeCity() {
        
        
        
    }


}


// MARK: - UITableViewDataSource Methods
extension ViewController: UITableViewDataSource {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return openWeatherResponse?.count ?? 0
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = openWeatherResponse?[indexPath.row].name
        return cell
    }

}

// MARK: - UITableViewDelegate Methods
extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.detailsViewSegue.rawValue, sender: self)
    }
}


// MARK: - UITableViewDelegate Methods
extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            manager.stopUpdatingLocation()
            getLocationFromDevice(location)
        }
    }
}
