//
//  AddTVShowController.swift
//  TVShowManager
//
//  Created by Sourabh Singh on 13/09/21.
//

import Foundation
import UIKit
import Cartography
import Parse
import Combine

class AddTVShowController: UIViewController, UITextFieldDelegate {
    
    @Published private var tvShowTitle: String = ""
    @Published private var releaseYear: String = ""
    @Published private var numberOfSeasons: String = ""
    
    private let addTVShowView = AddTVShowView()
    private var activityIndicator = UIActivityIndicatorView(style: .large)

    private var stream: AnyCancellable?

    init() {
        super.init(nibName: nil, bundle: nil)
        if #available(iOS 14.0, *) {
            navigationItem.backButtonTitle = NSLocalizedString("Add TV show", comment: "")
            navigationItem.backButtonDisplayMode = .minimal
        } else {
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        self.title = NSLocalizedString("Add new TV show", comment: "AddTVShowController title")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
    
        view.addSubview(addTVShowView)
        view.addSubview(activityIndicator)
        Cartography.constrain(addTVShowView, activityIndicator) {
            $0.edges == $0.superview!.edges
            $1.width == 100
            $1.height == 100
            $1.centerX == $1.superview!.centerX
            $1.centerY == $1.superview!.centerY
        }

        addTVShowView.saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        addTVShowView.saveButton.isEnabled = false

        for textfield in [addTVShowView.titleTextField, addTVShowView.numberOfSeasonsTextField, addTVShowView.yearOfReleaseTextField] {
            textfield.delegate = self
        }
    }
    
    override func viewDidLoad() {
        stream = validToSave
            .receive(on: RunLoop.main)
            .assign(to: \.isEnabled, on: addTVShowView.saveButton)
    }
    
    private var validToSave: AnyPublisher<Bool, Never> {
        let year = Calendar.current.component(.year, from: Date())
        return Publishers.CombineLatest3($tvShowTitle, $releaseYear, $numberOfSeasons)
            .map { title, release, seasons in
                !title.isBlank && !release.isBlank && (Int(release) ?? year <= year) && !seasons.isBlank
            }.eraseToAnyPublisher()
    }
    
    @objc private func saveTapped() {
        view.endEditing(true)
        let tvShow = PFObject.init(className: TVShow.parseClassName())
        tvShow["title"] = tvShowTitle
        tvShow["years"] = Int(releaseYear)
        tvShow["seasons"] = Int(numberOfSeasons)
        activityIndicator.startAnimating()
        tvShow.saveInBackground { [weak self] (succeeded, error) in
            guard let self = self else { return}
            self.activityIndicator.stopAnimating()
            if error == nil {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    // MARK: UitextFieldDelegate
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        switch textField {
        case (addTVShowView.titleTextField):
            tvShowTitle = newText
        case (addTVShowView.yearOfReleaseTextField):
            releaseYear = newText
        case (addTVShowView.numberOfSeasonsTextField):
            numberOfSeasons = newText
        default:
            assertionFailure("Unknown textfield ")
        }
        return true
    }
}
