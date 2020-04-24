//
//  Sale.swift
//  ProjectRosieJetson
//
//  Created by Thiago Nitschke Simões on 23/04/20.
//  Copyright © 2020 thnitschke. All rights reserved.
//

import Foundation

struct Sale: Codable {
    
    let id = UUID()
    
    var products: [Product] = []
    var payment: Payment?
    var date: Date = Date()
    
    var total: Double {
        products.reduce(0.0) { $0 + $1.price }
    }
    
    mutating func pay(method: Payment.PaymentMethod) {
        payment = Payment(type: method.rawValue)
    }
}
