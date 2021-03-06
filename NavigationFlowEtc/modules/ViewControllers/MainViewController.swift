//
//  MainViewController.swift
//  NavigationFlowSwiftBook
//
//  Created by Разработчик Foodle on 26/02/2020.
//  Copyright © 2020 Разработчик Foodle. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var menuDelegate: MenuDelegate?
    
    let monkeyImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "monkey"))
        imageView.translatesAutoresizingMaskIntoConstraints = true
        return imageView
    }()
    let bananImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "banan"))
        imageView.translatesAutoresizingMaskIntoConstraints = true
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowRadius = 3
        imageView.layer.masksToBounds = true
        imageView.layer.shadowOpacity = 0.8
        return imageView
    }()
    var location = CGPoint(x: 300, y: 400)
    var showed = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.lightGray
        title = "Main screen"
        let logoutButton = UIBarButtonItem(title: "Log out", style: .plain, target: self, action: #selector(logout))
        navigationItem.setRightBarButton(logoutButton, animated: true)
        let menuButton = UIBarButtonItem(image: UIImage(named: "menuButton"), style: .plain, target: self, action: #selector(toggleMenu))
        menuButton.tintColor = .black
        navigationItem.setLeftBarButton(menuButton, animated: true)
        
        
        view.addSubview(monkeyImageView)
        monkeyImageView.frame = CGRect(x: 300, y: 200, width: 200, height: 200)
        view.addSubview(bananImageView)
        bananImageView.frame = CGRect(x: 100, y: 200, width: 200, height: 200)
        
        monkeyImageView.center = view.center
        
        [bananImageView, monkeyImageView].forEach { (iv) in
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGest(_:)))
            panGestureRecognizer.delegate = self
            iv.addGestureRecognizer(panGestureRecognizer)
            let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
            pinchGestureRecognizer.delegate = self
            iv.addGestureRecognizer(pinchGestureRecognizer)
            let rotateGestureRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(handleRotate(_:)))
            rotateGestureRecognizer.delegate = self
            iv.addGestureRecognizer(rotateGestureRecognizer)
            iv.isUserInteractionEnabled = true
        }
    }
    
    @objc
    func panGest(_ gest: UIPanGestureRecognizer) {
        
        let translation = gest.translation(in: self.view)
        
        if let view: UIImageView = gest.view as? UIImageView {
        let point = gest.location(in: view)
            if view.layer.contains(point) {
//                print(view.image?.getPixelColor(pos: point))
//                print(point)
                var point = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
                point.x = min(max(point.x,view.bounds.width / 2), self.view.bounds.width - gest.view!.bounds.width / 2)
                point.y = min(max(point.y, view.bounds.height / 2), self.view.bounds.height - gest.view!.bounds.height / 2)
                view.center = point
                
            }
        }
        gest.setTranslation(CGPoint.zero, in: self.view)
        
        if gest.state == .ended {
//            print("ended")
            let velocity = gest.velocity(in: self.view)
            
//            let magnitude = sqrt((velocity.x * velocity.x) +(velocity.y * velocity.y))
//            let slideMultiplier = magnitude / 200
            
//            let slideFactor = 0.1 * slideMultiplier
            
            var finalPoint = CGPoint(x: gest.view!.center.x + (velocity.x / 20), y: gest.view!.center.y + (velocity.y / 20))
            
            finalPoint.x = min(max(finalPoint.x, gest.view!.bounds.width / 2), self.view.bounds.size.width - gest.view!.bounds.width / 2)
            finalPoint.y = min(max(finalPoint.y, gest.view!.bounds.height / 2), self.view.bounds.size.height - gest.view!.bounds.height / 2)

            UIView.animate(withDuration: 0.1, delay: 0, options: [.curveEaseOut], animations: {
                gest.view!.center = finalPoint
            }, completion: nil)
            
        }
    }
    
    @objc
    func handlePinch(_ recognizer: UIPinchGestureRecognizer){
        if let view = recognizer.view {
            view.transform = CGAffineTransform(scaleX: recognizer.scale, y: recognizer.scale)
//            recognizer.scale = 1
        }
    }
    
    @objc
    func handleRotate(_ recognizer: UIRotationGestureRecognizer) {
        if let view = recognizer.view {
            view.transform = CGAffineTransform(rotationAngle: recognizer.rotation)
            print(recognizer.rotation)
        }
    }
    
    /*
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        location = (touch?.location(in: self.view))!
        monkeyImageView.center = location
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        location = (touch?.location(in: self.view))!
        monkeyImageView.center = location
    }
    */
    
    @objc
    private func logout() {
        UserDefaults.standard.set(false, forKey: "LOGGED_IN")
        print("user logged out")
//        AppDelegate.shared.rootViewController.switchToLogout()
    }
    

    
    @objc
    private func toggleMenu() {
        print("menu")
        menuDelegate?.toggleMenu()
    }
}

extension MainViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith shouldRecognizeSimultaneouslyWithGestureRecognizer:UIGestureRecognizer) -> Bool {
      return true
    }
}


