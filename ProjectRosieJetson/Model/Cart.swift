//
//  Cart.swift
//  ProjectRosieJetson
//
//  Created by Thiago Nitschke Simões on 02/07/20.
//  Copyright © 2020 thnitschke. All rights reserved.
//

import Foundation

// Observer protocol (interface)
protocol CartSubscriber: CustomStringConvertible {

    func accept(changed cart: [Product])
}

// Subject (Observable)
class CartManager {

    private lazy var cart = [Product]()
    private lazy var subscribers = [CartSubscriber]()
    
    var count: Int {
        cart.count
    }

    func add(subscriber: CartSubscriber) {
        subscribers.append(subscriber)
    }

    func add(product: Product) {
        cart.append(product)
        notifySubscribers()
    }

    func remove(subscriber filter: (CartSubscriber) -> (Bool)) {
        guard let index = subscribers.firstIndex(where: filter) else { return }
        subscribers.remove(at: index)
    }

    func remove(index: Int) {
        cart.remove(at: index)
        notifySubscribers()
    }

    private func notifySubscribers() {
        subscribers.forEach({ $0.accept(changed: cart) })
    }
}

//extension UINavigationBar: CartSubscriber {
//
//    func accept(changed cart: [Product]) {
//        print("UINavigationBar: Updating an appearance of navigation items")
//    }
//
//    open override var description: String { return "UINavigationBar" }
//}
//
//class CartViewController: UIViewController, CartSubscriber {
//
//    func accept(changed cart: [Product]) {
//        print("CartViewController: Updating an appearance of a list view with products")
//    }
//
//    open override var description: String { return "CartViewController" }
//}
