//
//  ViewController.swift
//  combine-uikit-programmatic
//
//  Created by Kautilya Save on 4/18/23.
//

import UIKit
import swift_sense
import Foundation
import Combine


class ViewController: UIViewController {
    
    var isSubscribed: Bool = false
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MyCustomCell.self, forCellReuseIdentifier: "cell")
        return tableView
        
    }()
    
    var anyCancellables: Set<AnyCancellable> = Set<AnyCancellable>()
    var networkCancellable: AnyCancellable?
//    var data: [String] = []
    
    var users: [User] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        tableView.frame = view.bounds
        getData()
        getRemoteData()
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4 ) { [weak self] in
            
            print("Do not do anything!")
//            self?.networkCancellable?.cancel()
            
//            guard let cancels = self?.anyCancellables else { return }
//            for canel in cancels {
//                print("Hello Cancellables")
//                canel.cancel()
//            }
            
        }
        
        
        
    }
    
    
    func getData() {
//        data = ["Hello Data", " Kautilya" , "Save"]
        print("Nothing")
    }
    
    func getRemoteData() {
        networkCancellable = CombineNetwork
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
//            .store(in: &anyCancellables)

    }
    
//    func registerCellButtonCallbacks(cell: MyCustomCell, index: Int) {
//
//        cell.action.sink { val in
//            print("### \(index)", val)
//        }
//        .store(in: &anyCancellables)
//
//
//    }


}



extension ViewController: UITableViewDelegate ,UITableViewDataSource {
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        30
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MyCustomCell else {
            fatalError()
        }
        
//        let cellText = users[indexPath.row].firstName
//        // Deprecated
//        guard #available(iOS 15.0, *) else {
//            cell.textLabel?.text = cellText
//        }
//
//        var content = cell.defaultContentConfiguration()
//        content.text = cellText
//        content.secondaryText = "SK"
//        cell.contentConfiguration = content
        
        
        // Send combine events to function
//        registerCellButtonCallbacks(cell: cell, index: indexPath.row)
        // Couldn't figure out why "action.send("Hello from another World!")" subscribing twice. Maybe because I'm adding them from UITableView?
        // Granted that this is not the right approach to begin with.
        // Should have independent viewModel and not getting response from CustomCell.
        // Or else dont make network request and just `store(in: AnyCancellable)` once only.
        

        
        if !isSubscribed {
            print("Hello in once loop if ")
            cell.action.sink { val in
                print("### ", val)
            }
            .store(in: &anyCancellables)
            isSubscribed.toggle()
            print(isSubscribed)
        }
        
        
        
        return cell
    }
    
}

