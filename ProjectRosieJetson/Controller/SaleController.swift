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
    // Strategy object
    var paymentStrategy: Strategy = CashStrategy()
    // Observable object
    let cartManager = CartManager()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        cartManager.add(subscriber: self)
    }
    
    func update(strategy: Strategy) {
        self.paymentStrategy = strategy
    }
    
    @IBAction func moneyPaymentAction(_ sender: UIButton) {
        guard let sale = currentSale else { return }
        update(strategy: CashStrategy())
        paymentStrategy.runTransaction()
        presentClosingAlert(text: sale.pay(creator: CashFactory()))
    }
    
    @IBAction func cardPaymentAction(_ sender: UIButton) {
        guard let sale = currentSale else { return }
        update(strategy: CardProviderStrategy())
        paymentStrategy.runTransaction()
        presentClosingAlert(text: sale.pay(creator: CreditCardFactory()))
    }
    
    
    @IBAction func addItemAction(_ sender: UIButton) {
        let alert = UIAlertController(title: "Inserir produto", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Nome do produto..."
        })
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] action in
            
            guard let self = self else { return }
            
            self.cartManager.add(product: Product(code: 100, name: alert.textFields?.first?.text ?? "Arroz"))
//            self.tableView.insertRows(at: [IndexPath(row: self.cartManager.count - 1, section: 0)], with: .automatic)
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
        cartManager.remove(index: indexPath.row)
//        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if isBeingDismissed {
            if currentSale?.payment == nil {
                guard let sale = currentSale else { return }
                update(strategy: CardProviderStrategy())
                paymentStrategy.runTransaction()
                presentClosingAlert(text: sale.pay(creator: DebitCardFactory()))
            }
        }
    }
    
    func presentClosingAlert(text: String) {
        
        let alert = UIAlertController(title: "Pagamento realizado com sucesso!", message: text, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.dismiss(animated: true)
        
        previousController?.present(alert, animated: true)
    }
    
}

// Method called when observed object changes
extension SaleController: CartSubscriber {
    
    func accept(changed cart: [Product]) {
        currentSale?.products = cart
        tableView.reloadData()
    }
}
