//
//  SplashViewController.swift
//  NavigationFlowSwiftBook
//
//  Created by Разработчик Foodle on 26/02/2020.
//  Copyright © 2020 Разработчик Foodle. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    
    private let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(activityIndicator)
        activityIndicator.frame = view.bounds
        activityIndicator.backgroundColor = UIColor(white: 0, alpha: 0.4)
        
        makeServiceCall()
        
    }
    
    private func makeServiceCall() {
        activityIndicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
            
            self.activityIndicator.stopAnimating()
            AppDelegate.shared.window?.rootViewController = RootViewController()
        }
    }
}
