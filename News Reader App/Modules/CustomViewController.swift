//
//  CustomViewController.swift
//  News Reader App
//
//  Created by Apple  on 15/04/2026.
//

import UIKit
class CustomViewController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarAppearance()
    }

    private func setupTabBarAppearance() {
           tabBar.backgroundColor = UIColor.white
           let appearance = UITabBarAppearance()
           appearance.configureWithOpaqueBackground()
           appearance.backgroundColor = UIColor.white
           tabBar.tintColor = UIColor(hex: "#2E7D32")
           tabBar.unselectedItemTintColor = UIColor.systemGray
           tabBar.standardAppearance = appearance
           tabBar.scrollEdgeAppearance = appearance
       }

}
