//
//  ViewModel.swift
//  MVVMBusArchitectureTemplate
//
//  Created by Imran Sayeed on 3/5/21.
//

import Foundation

struct UserListViewModel {
    public var users: [User] = []
    
    public  func fetchUserList() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                return
            }
            let event: UserFecthEvent
            do {
                let users = try JSONDecoder().decode([User].self, from: data)
                event = UserFecthEvent(identifier: UUID().uuidString, result: .success(users))
            } catch let error {
                print(error)
                event = UserFecthEvent(identifier: UUID().uuidString, result: .failure(error))
            }
            Bus.shared.publish(type: .userFecth, event: event)
        }
        
        task.resume()
    }
}
