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
