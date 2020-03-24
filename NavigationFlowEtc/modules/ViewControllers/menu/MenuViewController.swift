//
//  MenuViewController.swift
//  NavigationFlowEtc
//
//  Created by Разработчик Foodle on 06/03/2020.
//  Copyright © 2020 Разработчик Foodle. All rights reserved.
//

import UIKit


class MenuViewController: UIViewController {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let menuTableManager = MenuTableManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuTableManager.tableView = tableView
        setupUI()
    }
    
    private func setupUI() {
        self.view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
    }
}
