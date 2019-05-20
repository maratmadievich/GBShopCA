//
//  CatalogViewController.swift
//  GBShop
//
//  Created by Admin on 5/20/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import UIKit

class CatalogViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let refreshControl = UIRefreshControl()
    
    var presenter: CatalogPresenterProtocol!
    
    
    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        configureView()
        
        presenter.getCatalogRows()
    }
    
    
    private func configureView() {
        
        presenter = CatalogPresenter(view: self)
        
        navigationItem.title = "Каталог"
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        tableView.refreshControl = refreshControl
        
        refreshControl.addTarget(self,
                                 action: #selector(refreshCatalog(_:)),
                                 for: .valueChanged)
    }
    
    
    @objc private func refreshCatalog(_ sender: Any) {
        
        presenter.refreshCatalogRows()
    }
    
    
    @IBAction func buttonProfileTapped(_ sender: Any) {
        
        presenter.showProfile()
    }
    

}

extension CatalogViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return presenter.getRowsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CatalogCell", for: indexPath) as! CatalogCell
        
        presenter.configure(cell: cell, forRow: indexPath.row)
        
        return cell
    }
    
}

extension CatalogViewController: CatalogView {
   
    func startLoading() {
        
    }
    
    func finishLoading() {
        
        refreshControl.endRefreshing()
    }
    
    func refreshCatalogView() {
        
        tableView.reloadData()
    }

}

extension CatalogViewController: ProtocolShowNetworkAlert {}

extension CatalogViewController: ProtocolShowView {}
