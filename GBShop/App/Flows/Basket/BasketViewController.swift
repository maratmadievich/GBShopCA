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
    @IBOutlet weak var buttonBuy: UIButton!
    
    
    private var configurator = BasketConfiguratorImplementation()
    var presenter: BasketPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    
    @IBAction func buttonBuyTapped(_ sender: Any) {
        
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
        
    }
    
    func finishLoading() {
        
    }
    
    func refreshProducts() {
        tableView.reloadData()
    }
    
    func setTotalAmout(text: String) {
        buttonBuy.setTitle(text, for: .normal)
    }
    
}

extension BasketViewController: ProtocolShowNetworkAlert {}
