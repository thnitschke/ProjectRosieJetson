//
//  Operator.swift
//  ProjectRosieJetson
//
//  Created by Thiago Nitschke Simões on 23/04/20.
//  Copyright © 2020 thnitschke. All rights reserved.
//

import Foundation

class Operator {
    
    var todayDate: Date? = Calendar.current.startOfDay(for: Date())
    var receipt: Double? = nil
    private var cashierList: [Cashier] = []
    private var totalValuesPerDay: [Date: Double] = [:]
    
    func openCashier(by operatorName: String) -> Cashier {
        if todayDate == nil {
            todayDate = Calendar.current.startOfDay(for: Date())
        }
        
        let newCashier = Cashier(operatorName: operatorName)
        cashierList.append(newCashier)
        
        return newCashier
    }
    
    func withdrawMoney() -> Double {
        let total = totalValuesPerDay[todayDate ?? Calendar.current.startOfDay(for: Date()), default: 0.0]
        receipt = total
        return total
    }
    
    func printReceipt() -> String {
        if receipt == nil {
            return "Nenhum valor foi retirado dos caixas."
        } else {
            let value = receipt!
            receipt = nil
            return "R$\(value) foram retirados pelo gerente."
        }
    }
    
    func finishSessions() {
        totalValuesPerDay.updateValue(
            cashierList.reduce(0.0) { $0 + $1.calculateTotal() },
            forKey: todayDate ?? Calendar.current.startOfDay(for: Date())
        )
        todayDate = nil
    }
    
}
