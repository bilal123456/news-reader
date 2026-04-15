//
//  ToastView.swift
//  News Reader App
//
//  Created by Apple  on 15/04/2026.
//

import Foundation


import UIKit

extension UIViewController {
    
    func showToast(message: String) {
        let toastLabel = UILabel()
        toastLabel.text = message
        toastLabel.textAlignment = .center
        toastLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        toastLabel.textColor = .white
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        toastLabel.numberOfLines = 0
        toastLabel.alpha = 0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        
        let padding: CGFloat = 16
        let maxWidth = self.view.frame.width - 40
        
        let size = toastLabel.sizeThatFits(CGSize(width: maxWidth, height: .greatestFiniteMagnitude))
        toastLabel.frame = CGRect(
            x: (self.view.frame.width - size.width - padding) / 2,
            y: self.view.frame.height - 120,
            width: size.width + padding,
            height: size.height + 10
        )
        
        self.view.addSubview(toastLabel)
        
        UIView.animate(withDuration: 0.4, animations: {
            toastLabel.alpha = 1
        }) { _ in
            UIView.animate(withDuration: 0.4, delay: 1.5, options: .curveEaseOut, animations: {
                toastLabel.alpha = 0
            }) { _ in
                toastLabel.removeFromSuperview()
            }
        }
    }
}
