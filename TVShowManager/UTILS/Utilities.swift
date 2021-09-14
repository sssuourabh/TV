//
//  Utilities.swift
//  TVShowManager
//
//  Created by Sourabh Singh on 14/09/21.
//

import Foundation
import UIKit

extension UIView {
    func addDropShadow() {
        backgroundColor = UIColor.clear
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.1
        layer.masksToBounds = false
    }

    func addBorderAndColor(color: UIColor, width: CGFloat, corner_radius: CGFloat = 0, clipsToBounds: Bool = false) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
        self.layer.cornerRadius = corner_radius
        self.clipsToBounds = clipsToBounds
    }
}

extension UITextField {

   func setPadding(left: CGFloat? = nil, right: CGFloat? = nil) {
       if let left = left {
          let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: left, height: self.frame.size.height))
          self.leftView = paddingView
          self.leftViewMode = .always
       }

       if let right = right {
           let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: right, height: self.frame.size.height))
           self.rightView = paddingView
           self.rightViewMode = .always
       }
   }
}

extension String {
    /// A Boolean value indicating whether a String is blank.
    /// The string is blank if it is empty or only contains whitespace.
    var isBlank: Bool {
        return allSatisfy { $0.isWhitespace }
    }
}

extension Optional where Wrapped == String {
    /// A Boolean value indicating whether an Optional String is blank.
    /// The optional string is blank if it is nil, empty or only contains whitespace.
    var isBlank: Bool {
        return self?.isBlank ?? true
    }
}
