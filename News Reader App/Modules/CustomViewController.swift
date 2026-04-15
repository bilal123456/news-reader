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

           // Background color
           tabBar.backgroundColor = UIColor.white

           // iOS 15+ proper appearance fix
           let appearance = UITabBarAppearance()
           appearance.configureWithOpaqueBackground()

           appearance.backgroundColor = UIColor.white

           // Selected item color (green theme)
           tabBar.tintColor = UIColor(hex: "#2E7D32")

           // Unselected item color
           tabBar.unselectedItemTintColor = UIColor.systemGray

           // Apply appearance
           tabBar.standardAppearance = appearance
           tabBar.scrollEdgeAppearance = appearance
       }

}
