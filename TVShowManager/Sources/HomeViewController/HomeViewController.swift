//
//  HomeViewController.swift
//  TVShowManager
//
//  Created by Sourabh Singh on 13/09/21.
//

import Foundation
import UIKit
import Cartography

class HomeViewController: UIViewController {

    // MARK: Properties
    let addNewTVShowButton = UIButton()
    let showListButton = UIButton()

    private let router: HomeViewRouter
    // MARK: Initialization
    init() {
        self.router = HomeViewRouterImpl()
        super.init(nibName: nil, bundle: nil)
        title = NSLocalizedString("TV Show Manager", comment: "Title string")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        addNewTVShowButton.setTitle(NSLocalizedString("Add new TV show", comment: "addNewTVShowButton title"), for: .normal)
        showListButton.setTitle(NSLocalizedString("Show list of added shows", comment: "showListButton title "), for: .normal)
        showListButton.addTarget(self, action: #selector(showListButtonTapped), for: .touchUpInside)
        addNewTVShowButton.addTarget(self, action: #selector(addNewTVShowButtonTapped), for: .touchUpInside)
        view.addSubview(addNewTVShowButton)
        view.addSubview(showListButton)
        
        updateButtonsUI()
        
        Cartography.constrain(addNewTVShowButton, showListButton) {
            $0.top == $0.superview!.top + 200
            $0.leading == $0.superview!.leading + 20
            $0.height == 50
            $0.trailing == $0.superview!.trailing - 20
            
            $1.top == $0.bottom + 16
            $1.leading == $0.leading
            $1.trailing == $0.trailing
            $1.height == $0.height
        }
    }

    //MARK: Private methods
    func updateButtonsUI() {
        [addNewTVShowButton, showListButton].forEach { button in
            button.layer.cornerRadius = 20
            button.backgroundColor = .systemBlue.withAlphaComponent(0.8)
        }
    }

    @objc func showListButtonTapped() {
        router.presentListOfTVShowController(from: self)
    }

    @objc func addNewTVShowButtonTapped() {
        router.presentAddTVShowController(from: self)
    }
}
