//
//  RootViewController.swift
//  NavigationFlowSwiftBook
//
//  Created by Разработчик Foodle on 26/02/2020.
//  Copyright © 2020 Разработчик Foodle. All rights reserved.
//

import UIKit


class RootViewController: UIViewController {
    
    private var current: UIViewController
    
    init() {
        self.current = SplashViewController()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(current)
        current.view.frame = view.bounds
        view.addSubview(current.view)
        current.didMove(toParent: self)
        
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
