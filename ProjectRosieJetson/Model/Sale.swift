//
//  Sale.swift
//  ProjectRosieJetson
//
//  Created by Thiago Nitschke Simões on 23/04/20.
//  Copyright © 2020 thnitschke. All rights reserved.
//

import Foundation

class Sale {
    
    let id = UUID()
    
    var products: [Product] = []
    var payment: Payment? = nil
    var date: Date = Date()
    
    var total: Double {
        products.reduce(0.0) { $0 + $1.price }
    }
    
    func addProduct(_ product: Product) {
        self.products.append(product)
    }
    
    func removeProduct(index: Int) {
        self.products.remove(at: index)
    }
    
    func pay(creator: PaymentFactory) -> String {
        payment = creator.createPayment()
        return payment?.pay(value: total) ?? "Erro!"
    }
}
