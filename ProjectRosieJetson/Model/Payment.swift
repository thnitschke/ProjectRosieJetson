//
//  Payment.swift
//  ProjectRosieJetson
//
//  Created by Thiago Nitschke Simões on 23/04/20.
//  Copyright © 2020 thnitschke. All rights reserved.
//

import Foundation

// Factory pattern
protocol PaymentFactory {

    func createPayment() -> Payment
    
    func pay(value: Double) -> String
}

// Default implementation
extension PaymentFactory {
    
    func pay(value: Double) -> String {
        let payment = createPayment()
        
        return payment.pay(value: value)
    }
}

class DebitCardFactory: PaymentFactory {

    func createPayment() -> Payment {
        return DebitCardPayment()
    }
}

class CreditCardFactory: PaymentFactory {

    func createPayment() -> Payment {
        return CreditCardPayment()
    }
}

class CashFactory: PaymentFactory {
    
    func createPayment() -> Payment {
        return CashPayment()
    }
}

protocol Payment {
    
    func pay(value: Double) -> String
}

extension Payment {
    
    func pay(value: Double) -> String {
        return "Erro! Pagamento inválido."
    }
}

struct DebitCardPayment: Payment {

    func pay(value: Double) -> String {
        return "Valor R$\(value) pago através de cartão de débito."
    }
}

struct CreditCardPayment: Payment {

    func pay(value: Double) -> String {
        return "Valor R$\(value) pago através de cartão de crédito."
    }

}

struct CashPayment: Payment {
    
    func pay(value: Double) -> String {
        return "Valor R$\(value) pago em dinheiro."
    }

}

// Strategy pattern
protocol Strategy {

    func runTransaction()
}

class CashStrategy: Strategy {

    func runTransaction() {
        sleep(0)
    }
}

class CardProviderStrategy: Strategy {

    func runTransaction() {
        sleep(arc4random_uniform(4) + 2)
    }
}
