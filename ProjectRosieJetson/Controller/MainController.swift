//
//  MainController.swift
//  ProjectRosieJetson
//
//  Created by Thiago Nitschke Simões on 22/04/20.
//  Copyright © 2020 thnitschke. All rights reserved.
//

import UIKit

class MainController: UIViewController {
    
    // Use singleton operator
    let system = Operator.shared()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func openCashierAction(_ sender: UIButton) {
        let alert = UIAlertController(title: "Qual o nome do operador?", message: nil, preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Digite o nome aqui..."
        })
        
        alert.addAction(UIAlertAction(title: "Pronto", style: .default, handler: { [weak self] action in
            
            guard let self = self else { return }
            
            self.performSegue(withIdentifier: "openCashier", sender: self.system.openCashier(by: alert.textFields?.first?.text ?? "Desconhecido"))
        }))
        
        self.present(alert, animated: true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openCashier" {
            let vc = segue.destination as? CashierController
            vc?.previousController = self
            vc?.currentCashier = sender as? Cashier
        }
        if segue.identifier == "finishSession" {
            let vc = segue.destination as? ManagerController
            system.finishSessions()
            vc?.system = system
        }
    }
    
}

