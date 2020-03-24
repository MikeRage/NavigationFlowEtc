//
//  MenuTableManager.swift
//  NavigationFlowEtc
//
//  Created by Разработчик Foodle on 06/03/2020.
//  Copyright © 2020 Разработчик Foodle. All rights reserved.
//

import UIKit

class MenuTableManager: NSObject {
    
    private let menuItems = [MenuItem(title: "Main"),
                              MenuItem(title: "something"),
                              MenuItem(title: "esle"),
                              MenuItem(title: "exit?")]
    var tableView: UITableView? {
        didSet {
            tableView?.delegate = self
            tableView?.dataSource = self
            tableView?.register(MenuTableViewCell.self, forCellReuseIdentifier: "menuItem")
        }
    }
}

extension MenuTableManager: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MenuTableViewCell = tableView.dequeueReusableCell(withIdentifier: "menuItem", for: indexPath) as! MenuTableViewCell
        let menuItem = menuItems[indexPath.row]
        cell.titleLabel.text = menuItem.title
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension MenuTableManager: UITableViewDelegate {
    
}
