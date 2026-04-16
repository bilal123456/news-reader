//
//  Keyboard + Extension.swift
//  News Reader App
//
//  Created by Apple  on 16/04/2026.
//

import UIKit
import Kingfisher

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UIView {
    func applyCardStyle() {
        layer.cornerRadius = 12
        layer.borderWidth = 1
        layer.borderColor = UIColor(hex: "#EEEEEE").cgColor
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.05
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 8
        
        layer.masksToBounds = false
    }
}

extension UIImageView {
    func setImage(urlString: String?) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            self.image = UIImage(systemName: "photo")
            return
        }

        kf.setImage(
            with: url,
            placeholder: UIImage(systemName: "photo"),
            options: [.transition(.fade(0.3)), .cacheOriginalImage]
        )
    }
}

extension NSAttributedString {
    static func calendarText(date: String) -> NSAttributedString {
        let attachment = NSTextAttachment()
        attachment.image = UIImage(systemName: "calendar")

        let icon = NSAttributedString(attachment: attachment)
        let text = NSAttributedString(string: " \(date)")

        let result = NSMutableAttributedString()
        result.append(icon)
        result.append(text)
        return result
    }
}
