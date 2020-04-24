//
//  Product.swift
//  ProjectRosieJetson
//
//  Created by Thiago Nitschke Simões on 23/04/20.
//  Copyright © 2020 thnitschke. All rights reserved.
//

import Foundation

struct Product: Codable {
    
    let id: UUID = UUID()
    private let priceChoices = [
        1.99,
        2.50,
        7.35,
        4.72,
        5.99,
        10.22,
        50.19,
        99.99
    ]
    
    var code: Int
    var name: String
    var price: Double
    
    init(code: Int, name: String) {
        self.code = code
        self.name = name
        self.price = priceChoices.randomElement() ?? 1.99
    }
    
}
