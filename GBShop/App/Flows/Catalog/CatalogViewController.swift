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
    @IBOutlet weak var searchBar: UISearchBar!
    
    private let refreshControl = UIRefreshControl()
    
    private var configurator = CatalogConfiguratorImplementation()
    var presenter: CatalogPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(catalogViewController: self)
        configureView()
        presenter.getCatalogRows()
    }
    
    private func configureView() {
        navigationItem.title = "Каталог"
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.refreshControl = refreshControl
        
        refreshControl.addTarget(self,
                                 action: #selector(refreshCatalog(_:)),
                                 for: .valueChanged)
    }
    
    @objc private func refreshCatalog(_ sender: Any) {
        searchBar.text = ""
        presenter.refreshCatalogRows()
    }
    
    @IBAction func buttonProfileTapped(_ sender: Any) {
        presenter.showProfile()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.router.prepare(for: segue, sender: sender)
    }

}

extension CatalogViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.rowsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CatalogCell", for: indexPath) as! CatalogCell
        presenter.configure(cell: cell, forRow: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == presenter.rowsCount - 1 {
            presenter.getCatalogRows()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.selectRow(row: indexPath.row)
    }
    
}

extension CatalogViewController: CatalogView {
   
    func startLoading() {}
    
    func finishLoading() {
        refreshControl.endRefreshing()
    }
    
    func refreshCatalogView() {
        tableView.reloadData()
    }

}

extension CatalogViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.changeSearchText(searchText)
    }
}

extension CatalogViewController: ProtocolShowNetworkAlert {}

extension CatalogViewController: ProtocolShowView {}
