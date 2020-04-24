//
//  CashierController.swift
//  ProjectRosieJetson
//
//  Created by Thiago Nitschke Simões on 23/04/20.
//  Copyright © 2020 thnitschke. All rights reserved.
//

import UIKit

class CashierController: UIViewController {
    
    var previousController: UIViewController?
    var currentCashier: Cashier?
    
    @IBOutlet weak var cashierTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cashierTitle.text = """
        Caixa: \(currentCashier?.id.uuidString.last ?? "X")
        Operador: \(currentCashier?.operatorName ?? "X")
        """
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if isBeingDismissed {
            currentCashier?.close()
            
            presentClosingAlert()
        }
    }
    
    func presentClosingAlert() {
        
        let alert = UIAlertController(title: "Caixa fechado!", message: "Fechado com um valor em caixa de R$\(currentCashier?.calculateTotal() ?? 0.0)", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        previousController?.present(alert, animated: true)
    }
    
    @IBAction func closeCashierAction(_ sender: UIButton) {
        currentCashier?.close()
        
        self.dismiss(animated: true)
        
        presentClosingAlert()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "startSale" {
            let vc = segue.destination as? SaleController
            vc?.previousController = self
            vc?.currentSale = currentCashier?.startSale()
        }
    }
    
}
