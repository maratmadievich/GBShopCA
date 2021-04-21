//
//  BasketViewController.swift
//  GBShop
//
//  Created by Admin on 5/28/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

class BasketViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
     @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var buttonBuy: UIButton!
    
    private var configurator = BasketConfiguratorImplementation()
    var presenter: BasketPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(basketViewController: self)
        configureView()
        presenter.viewDidLoad()
    }
    
    private func configureView() {
        navigationItem.title = "Корзина"
        activityIndicator.isHidden = true
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    
    @IBAction func buttonBuyTapped(_ sender: Any) {
        presenter.buyProducts()
    }
    

}

extension BasketViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.rowsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasketTableViewCell", for: indexPath) as! BasketTableViewCell
        presenter.configure(cell: cell, forRow: indexPath.row)
        return cell
    }
    
    
}

extension BasketViewController: BasketView {
    
    func startLoading() {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
    }
    
    func finishLoading() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }
    
    func refreshProducts() {
        tableView.reloadData()
    }
    
    func setTotalAmout(text: String) {
        buttonBuy.setTitle(text, for: .normal)
    }
    
    func showError(text: String) {
        let alert = UIAlertController(title: "Ошибка", message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Хорошо", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func showSuccess(title: String, text: String) {
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Хорошо", style: .default, handler: {
            [unowned self] action in
            
            self.presenter.router.dismiss()
        }))
        self.present(alert, animated: true)
    }
    
}
