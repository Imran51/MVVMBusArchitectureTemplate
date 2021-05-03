//
//  Event.swift
//  MVVMBusArchitectureTemplate
//
//  Created by Imran Sayeed on 3/5/21.
//

import Foundation

class Event<T>  {
    let identifier: String
    let result: Result<T,Error>?
    
    public init(identifier: String, result: Result<T,Error>?) {
        self.identifier = identifier
        self.result = result
    }
}


class UserFecthEvent: Event<[User]> {
    
}


struct User: Codable {
    let name: String
}
