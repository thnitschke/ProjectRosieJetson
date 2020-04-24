//
//  Payment.swift
//  ProjectRosieJetson
//
//  Created by Thiago Nitschke Simões on 23/04/20.
//  Copyright © 2020 thnitschke. All rights reserved.
//

import Foundation

struct Payment: Codable {
    
    let id: UUID = UUID()
    var type: Int
    
    func externalTransactionTime() -> Int {
        return 2
    }
    
    enum PaymentType: Int {
        case cash, creditCard, debitCard
        
        func description() -> String {
            switch self {
            case .cash:
                return "Dinheiro"
            case .creditCard:
                return "Cartão de Crédito"
            case .debitCard:
                return "Cartão de Débito"
            }
        }
    }
    
}
