//
//  LoginViewController.swift
//  NavigationFlowSwiftBook
//
//  Created by Разработчик Foodle on 26/02/2020.
//  Copyright © 2020 Разработчик Foodle. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        title = "login screen"
        let loginButton = UIBarButtonItem(title: "log in", style: .plain, target: self, action: #selector(login))
        navigationItem.setRightBarButton(loginButton, animated: true)
    }
    
    
    @objc
    private func login() {
        UserDefaults.standard.set(true, forKey: "LOGGED_IN")
        print("user logged in")
        AppDelegate.shared.rootViewController.switchToMainScreen()
    }
}
