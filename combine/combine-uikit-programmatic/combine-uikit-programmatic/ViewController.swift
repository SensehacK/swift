//
//  ViewController.swift
//  combine-uikit-programmatic
//
//  Created by Kautilya Save on 4/18/23.
//

import UIKit
import swift_sense
import Combine

class MyCustomCell: UITableViewCell {
    
}

class ViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MyCustomCell.self, forCellReuseIdentifier: "cell")
        return tableView
        
    }()
    
    var anyCancellables: Set<AnyCancellable> = Set<AnyCancellable>()
//    var data: [String] = []
    
    var users: [User] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        tableView.frame = view.bounds
        getData()
        getRemoteData()
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    
    func getData() {
//        data = ["Hello Data", " Kautilya" , "Save"]
        print("Nothing")
    }
    
    func getRemoteData() {
        CombineNetwork
            .shared
            .fetchData(url: "https://dummyjson.com/users", type: UsersAPI.self)
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .failure(_):
                    print("Error")
                case .finished:
                    print("Finish")
                }
            } receiveValue: { [weak self] response in
                self?.users = response.users
                print(response.users.count)
                self?.tableView.reloadData()
            }
            .store(in: &anyCancellables)

    }


}



extension ViewController: UITableViewDelegate ,UITableViewDataSource {
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MyCustomCell else {
            return UITableViewCell()
        }
        
        let cellText = users[indexPath.row].firstName
        // Deprecated
        guard #available(iOS 15.0, *) else {
            cell.textLabel?.text = cellText
        }
        
        var content = cell.defaultContentConfiguration()
        content.text = cellText
        content.secondaryText = "SK"
        cell.contentConfiguration = content
        
        return cell
    }
    
}

