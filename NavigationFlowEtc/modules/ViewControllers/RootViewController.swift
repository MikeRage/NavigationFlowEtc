//
//  RootViewController.swift
//  NavigationFlowSwiftBook
//
//  Created by Разработчик Foodle on 26/02/2020.
//  Copyright © 2020 Разработчик Foodle. All rights reserved.
//

import UIKit

protocol MenuDelegate {
    
    func toggleMenu()
}

class RootViewController: UIViewController {
    
    var menuOpened = false
    private let contentView = UIView()
    private var current: UIViewController!
    private var menu = MenuViewController()
    
    init() {
        
        super.init(nibName: nil, bundle: nil)
        
        if UserDefaults.standard.bool(forKey: "LOGGED_IN") {
//            AppDelegate.shared.rootViewController.switchToMainScreen()
        } else {
//            AppDelegate.shared.rootViewController.showLoginScreen()
            
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChild(menu)
        view.addSubview(menu.view)
        
        view.addSubview(contentView)
        contentView.frame = view.bounds
        
        let mainViewController = MainViewController()
        mainViewController.menuDelegate = self
        let navigationController = UINavigationController(rootViewController: mainViewController)
        navigationController.isNavigationBarHidden = false
        addChild(navigationController)
        navigationController.view.frame = contentView.frame
        contentView.addSubview(navigationController.view)
        navigationController.didMove(toParent: self)
        
        print("RootVC loaded")
    }
    
    func showLoginScreen() {
        let new = UINavigationController(rootViewController: LoginViewController())
        
        addChild(new)
        new.view.frame = view.bounds
        view.addSubview(new.view)
        new.didMove(toParent: self)
        current.view.removeFromSuperview()
        current.removeFromParent()
        current = new
    }
    
    func switchToMainScreen() {
        let mainViewController = MainViewController()
        let mainScreen = UINavigationController(rootViewController: mainViewController)
        animateFadeTransition(to: mainScreen)
    }
    
    func switchToLogout() {
        let loginViewController = LoginViewController()
        let logoutScreen = UINavigationController(rootViewController: loginViewController)
        animateDismissTransition(to: logoutScreen)
    
    }
    
    private func animateFadeTransition(to new: UIViewController, completion: ( () -> Void)? = nil) {
        current.willMove(toParent: nil)
        addChild(new)
        transition(from: current,
                   to: new,
                   duration: 0.3,
                   options: [ .curveEaseOut, .transitionCrossDissolve],
                   animations: {
        }) { (completed) in
            self.current.removeFromParent()
            new.didMove(toParent: self)
            self.current = new
            completion?()
        }
    }
    
    private func animateDismissTransition(to new: UIViewController, completion: (() -> Void)? = nil) {
        let  initialFrame = CGRect(x: -view.bounds.width, y: 0, width: view.bounds.width, height: view.bounds.height)
        
        current.willMove(toParent: nil)
        addChild(new)
        new.view.frame = initialFrame
        transition(from: current, to: new, duration: 0.3, options: [], animations: {
            
            new.view.frame = self.view.bounds
        }) { (completed) in
            self.current.removeFromParent()
            new.didMove(toParent: self)
            self.current = new
            completion?()
        }
    }
}

extension RootViewController: MenuDelegate {
    
    func toggleMenu() {
        
        if menuOpened {
                        UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut, animations: {
                            self.contentView.frame.origin.x = 0
            }) { (finished) in
                
            }
            
        } else {
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut, animations: {
                            self.contentView.frame.origin.x = self.contentView.frame.width - 140
            }) { (finished) in
                
            }
        }
        menuOpened = !menuOpened
    }

}
