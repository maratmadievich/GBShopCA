//
//  ProductInfoViewController.swift
//  GBShop
//
//  Created by Марат Нургалиев on 27/05/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

class ProductInfoViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var labelProductName: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    
    public var configurator: ProductInfoConfigurator!
    internal var presenter: ProductInfoPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        configureView()
        
    }
    
    private func configureView() {
        navigationItem.title = "О товаре"
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    @IBAction func buttonAddToBasketTapped(_ sender: Any) {
        showProductCountAlert()
    }
    
    private func showProductCountAlert() {
        
        let alert = UIAlertController(title: "Добавление товара", message: "Please input something", preferredStyle: UIAlertController.Style.alert)
        
        let action = UIAlertAction(title: "Добавить", style: .default) { (alertAction) in
            let textField = alert.textFields![0] as UITextField
            let quantityString = textField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            self.presenter.addToBasket(quantityString: quantityString)
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Количество"
            textField.keyboardType = .numberPad
            textField.delegate = self
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .default) { (alertAction) in
            alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(action)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true)
    }
    
}

extension ProductInfoViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if range.length == 0 && range.location == 0 && string == "0" {
            return false
        }
        return true
    }
}

extension ProductInfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.rowsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductInfoTableViewCell", for: indexPath) as! ProductInfoTableViewCell
        presenter.configure(cell: cell, forRow: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == presenter.rowsCount - 1 {
            presenter.getReviewRows()
        }
    }
}

extension ProductInfoViewController: ProductInfoView {
    
    func setProductName(text: String) {
        labelProductName.text = text
    }
    
    func setProductPrice(text: String) {
        labelPrice.text = text
    }
    
    func startLoading() {
        
    }
    
    func finishLoading() {
        
    }
    
    func refreshReviews() {
        tableView.reloadData()
    }
    
}

extension ProductInfoViewController: ProtocolShowNetworkAlert {}
