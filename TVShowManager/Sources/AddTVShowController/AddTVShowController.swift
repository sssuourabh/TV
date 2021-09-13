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

class AddTVShowController: UIViewController {
    
    private let addTVShowView = AddTVShowView()
    
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

        Cartography.constrain(addTVShowView) {
            $0.edges == $0.superview!.edges
        }

        addTVShowView.saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
    }
    
    override func viewDidLoad() {

    }
    
    @objc private func saveTapped() {
        let tvShow = PFObject(className: "TVShow")
        tvShow["title"] = "Stranger things"
        tvShow["years"] = 2014
        tvShow["seasons"] = 4
        print("tvshowid = \(String(describing: tvShow.objectId))")
        tvShow.saveInBackground { [weak self] (succeeded, error) in
            guard let self = self else { return}
            if succeeded {
                self.navigationController?.popToRootViewController(animated: true)
            } else {
                print(error?.localizedDescription)
            }
        }
    }
}
