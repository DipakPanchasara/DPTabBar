//
//  FlowtingViewController.swift
//  DPTabBar_Example
//
//  Created by Dipak Panchasara on 18/03/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import DPTabBar

class FlowtingViewController: DPTabBarController {

    override func viewDidLoad() {
        self.title = "Floating TabBar"
        self.setupUI()
        super.viewDidLoad()
    }
    

    func setupUI() {
        self.tabBar.shapeType = .floating
        UIViewController.setUpTabBar()
        self.tabBar.selectedImage = UIImage.imageWithColor(color: UIColor.red, size: CGSize(width: 45, height: 50))
        
        let vc1 = UIViewController()
        vc1.tabBarItem = UITabBarItem(title: "HOME", image: UIImage.imageWithColor(color: UIColor.red, size: CGSize(width: 24, height: 24)), tag: 1)
        
        let vc2 = UIViewController()
        vc2.tabBarItem = UITabBarItem(title: "HOME", image: UIImage.imageWithColor(color: UIColor.red, size: CGSize(width: 24, height: 24)), tag: 1)
        let vc3 = UIViewController()
        vc3.tabBarItem = UITabBarItem(title: "HOME", image: UIImage.imageWithColor(color: UIColor.red, size: CGSize(width: 24, height: 24)), tag: 1)
        self.viewControllers = [vc1, vc2, vc3]
    }

}
