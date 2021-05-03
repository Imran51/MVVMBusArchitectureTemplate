//
//  ViewController.swift
//  MVVMBusArchitectureTemplate
//
//  Created by Imran Sayeed on 3/5/21.
//

import UIKit

class ViewController: UIViewController {
    
    private var viewModel = UserListViewModel()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        
        tableView.dataSource = self
        Bus.shared.subscribeOnMainThread(.userFecth) {[weak self] event in
            guard let result = event.result else {
                return
            }
            switch result {
            case .success(let users):
                self?.viewModel.users = users
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
        
        viewModel.fetchUserList()
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = self.view.bounds
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = viewModel.users[indexPath.row].name
        
        return cell
    }
    
    
}

