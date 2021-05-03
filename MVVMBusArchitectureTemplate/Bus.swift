//
//  Bus.swift
//  MVVMBusArchitectureTemplate
//
//  Created by Imran Sayeed on 3/5/21.
//

import Foundation

final  class Bus {
    static let shared = Bus()
    
    private init() {}
    
    enum EventType {
        case userFecth
    }
    
    private var subscriptions = [Subscription]()
    
    struct Subscription {
        let type: EventType
        let queue: DispatchQueue
        let block: ((Event<[User]>) -> Void)
    }
    
    func subscribe(_ event: EventType, block: @escaping ((Event<[User]>) -> Void)) {
        let newSubcription = Subscription(type: event, queue: .global(), block: block)
        
        subscriptions.append(newSubcription)
    }
    
    func subscribeOnMainThread(_ event: EventType, block: @escaping ((Event<[User]>) -> Void)) {
        let newSubcription = Subscription(type: event, queue: .main, block: block)
        
        subscriptions.append(newSubcription)
    }
    
    func publish(type: EventType, event: Event<[User]>) {
        let subscribers = subscriptions.filter({ $0.type == type })
        
        subscribers.forEach{ subscriber in
            subscriber.queue.async {
                subscriber.block(event)
            }
        }
    }
}
