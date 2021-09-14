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
    public var saveButton = MyButton()
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

        saveButton.backgroundColor = .systemBlue
        [titleTextField, yearOfReleaseTextField, numberOfSeasonsTextField].forEach { textField in
            textField.setPadding(left: 10, right: 10)
            textField.addBorderAndColor(color: .gray, width: 1, corner_radius: 5)
        }
        titleTextField.keyboardType = .default
        yearOfReleaseTextField.keyboardType = .numberPad
        numberOfSeasonsTextField.keyboardType = .numberPad
        saveButton.layer.cornerRadius = 20
        
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

class MyButton: UIButton {
    override public var isEnabled: Bool {
        didSet {
            self.backgroundColor = self.backgroundColor?.withAlphaComponent(self.isEnabled ? 1.0 : 0.5)
        }
    }
}
