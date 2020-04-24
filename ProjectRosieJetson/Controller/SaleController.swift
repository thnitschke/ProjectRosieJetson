//
//  SaleController.swift
//  ProjectRosieJetson
//
//  Created by Thiago Nitschke Simões on 23/04/20.
//  Copyright © 2020 thnitschke. All rights reserved.
//

import UIKit

class SaleController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var previousController: UIViewController?
    var currentSale: Sale?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @IBAction func moneyPaymentAction(_ sender: UIButton) {
        currentSale?.pay(method: .cash)
        presentClosingAlert()
    }
    
    @IBAction func cardPaymentAction(_ sender: UIButton) {
        currentSale?.pay(method: .creditCard)
        presentClosingAlert()
    }
    
    
    @IBAction func addItemAction(_ sender: UIButton) {
        let alert = UIAlertController(title: "Inserir produto", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Nome do produto..."
        })
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] action in
            
            guard let self = self else { return }
            
            self.currentSale?.products.append(Product(code: 100, name: alert.textFields?.first?.text ?? "Arroz"))
            self.tableView.insertRows(at: [IndexPath(row: (self.currentSale?.products.count)! - 1, section: 0)], with: .automatic)
        }))
        
        self.present(alert, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Lista de Produtos"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currentSale?.products.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath)
        
        guard let productCell = cell as? ProductTableViewCell else { return UITableViewCell() }
        
        let product = currentSale?.products[indexPath.row] ?? Product(code: 100, name: "Arroz")
        
        productCell.configureCell(code: String(product.id.uuidString.suffix(8)), name: product.name)
        
        return productCell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        currentSale?.products.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if isBeingDismissed {
            if currentSale?.payment == nil {
                currentSale?.pay(method: .debitCard)
                presentClosingAlert()
            }
        }
    }
    
    func presentClosingAlert() {
        
        let alert = UIAlertController(title: "Pagamento realizado com sucesso!", message: "Valor R$\(currentSale?.total ?? 0.0) pago através de \(Payment.PaymentMethod(rawValue: (currentSale?.payment!.type)!)!.description()).", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.dismiss(animated: true)
        
        previousController?.present(alert, animated: true)
    }
    
}
