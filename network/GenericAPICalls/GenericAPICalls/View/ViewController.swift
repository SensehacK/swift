//
//  ViewController.swift
//  GenericAPICalls
//
//  Created by Kautilya Save on 9/8/22.
//

import UIKit

class ViewController: UIViewController {

    private var model: [Codable] = []
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(table)
        table.delegate = self
        table.dataSource = self
        // Fetch users
        fetchUsersData()
//        fetchTodoData()
    }
    
    private let table: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = view.bounds
    }
    

    func fetchUsersData() {
        
        URLSession.shared.request(url: Constants.userURL, expecting: [User].self) { [weak self] result in
            switch result {
            case .success(let data):
                self?.model = data
                
                DispatchQueue.main.async {
                    self?.table.reloadData()
                }
                
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        
    }
    
    
    func fetchTodoData() {
        
        URLSession.shared.request(url: Constants.todoListURL, expecting: [TodoList].self) { [weak self] result in
            switch result {
            case .success(let data):
                self?.model = data
                
                DispatchQueue.main.async {
                    self?.table.reloadData()
                }
                
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        
    }


}

// Delegates
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = (model[indexPath.row] as? User)?.name
        
        if let todoList = model[indexPath.row] as? TodoList {
            cell.textLabel?.text = todoList.title
            cell.accessoryType = todoList.completed ? .checkmark : .none
        }
//        cell.textLabel?.text = (model[indexPath.row] as? TodoList)?.title
        
//        if let item = mo
        return cell
    }
    
}
