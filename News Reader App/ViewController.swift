//
//  ViewController.swift
//  News Reader App
//
//  Created by Apple  on 14/04/2026.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        moveToNextController()
    }
    
    func moveToNextController() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            let homeController: CustomViewController = CustomViewController.instantiate(appStoryboard: .main)
            self.navigationController?.pushViewController(homeController,animated:true)
            
            
        })
        

    }


}

