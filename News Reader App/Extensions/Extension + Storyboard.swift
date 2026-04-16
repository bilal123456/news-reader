//
//  Extension + Storyboard.swift
//  News Reader App
//
//  Created by Apple  on 14/04/2026.
//

import UIKit


enum AppStoryboard: String {
   case main = "Main"
   
}

extension UIViewController {

    class func instantiate<T: UIViewController>(appStoryboard: AppStoryboard) -> T {

        let storyboard = UIStoryboard(name: appStoryboard.rawValue, bundle: nil)
        let identifier = String(describing: self)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! T
    }
}
