//
//  Cashier.swift
//  ProjectRosieJetson
//
//  Created by Thiago Nitschke Simões on 23/04/20.
//  Copyright © 2020 thnitschke. All rights reserved.
//

import Foundation

class Cashier {
    
    let id = UUID()
    
    var operatorName: String
    var openingDate: Date = Date()
    var closingDate: Date? = nil
    
    var sales: [Sale] = []
    
    init(operatorName: String) {
        self.operatorName = operatorName
    }
    
    func close() {
        closingDate = Date()
    }
    
    func startSale() -> Sale {
        let newSale = Sale()
        sales.append(newSale)
        return newSale
    }
    
    func calculateTotal() -> Double {
        return sales.reduce(0.0) { $0 + $1.total }
    }
    
}
