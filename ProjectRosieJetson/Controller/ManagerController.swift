//
//  ManagerController.swift
//  ProjectRosieJetson
//
//  Created by Thiago Nitschke Simões on 23/04/20.
//  Copyright © 2020 thnitschke. All rights reserved.
//

import UIKit

class ManagerController: UIViewController {
    
    var system: Operator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func presentAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    @IBAction func withdrawMoneyAction(_ sender: UIButton) {
        presentAlert(title: "Retirada de valores", message: "\((system?.withdrawMoney())!)")
    }
    
    @IBAction func printReceiptAction(_ sender: UIButton) {
        presentAlert(title: "Recibo", message: (system?.printReceipt())!)
    }
}
