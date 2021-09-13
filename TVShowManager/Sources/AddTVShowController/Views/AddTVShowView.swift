//
//  AddTVShowView.swift
//  TVShowManager
//
//  Created by Sourabh Singh on 13/09/21.
//

import Foundation
import Carbon
import Cartography

class AddTVShowView: UIView {
    public let titleTextField = UITextField()
    public let yearOfReleaseTextField = UITextField()
    public let numberOfSeasonsTextField = UITextField()
    public let saveButton = UIButton()
    public let stackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        titleTextField.placeholder = NSLocalizedString("Title", comment: "")
        yearOfReleaseTextField.placeholder = NSLocalizedString("Year of release", comment: "")
        numberOfSeasonsTextField.placeholder = NSLocalizedString("Number of episodes", comment: "")
        saveButton.setTitle(NSLocalizedString("Save", comment: "save title"), for: .normal)

        saveButton.backgroundColor = .systemBlue.withAlphaComponent(0.8)
        [titleTextField, yearOfReleaseTextField, numberOfSeasonsTextField].forEach { textField in
            textField.setPadding(left: 10, right: 10)
            textField.addBorderAndColor(color: .gray, width: 1, corner_radius: 5)
        }
        
        saveButton.addBorderAndColor(color: .clear, width: 0, corner_radius: 20, clipsToBounds: true)
        
        // adding on view
        stackView.addArrangedSubview(titleTextField)
        stackView.addArrangedSubview(yearOfReleaseTextField)
        stackView.addArrangedSubview(numberOfSeasonsTextField)
        stackView.addArrangedSubview(saveButton)
        addSubview(stackView)

        constrain(stackView) { stackView in
            let superview = stackView.superview!
            stackView.top == superview.topMargin + 50
            stackView.leading == superview.leadingMargin
            stackView.trailing == superview.trailingMargin
            stackView.height == 230
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

extension UIView {
    func addBorderAndColor(color: UIColor, width: CGFloat, corner_radius: CGFloat = 0, clipsToBounds: Bool = false) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
        self.layer.cornerRadius = corner_radius
        self.clipsToBounds = clipsToBounds
    }
}
