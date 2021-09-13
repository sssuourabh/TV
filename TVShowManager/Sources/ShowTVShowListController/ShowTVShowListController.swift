//
//  ShowTVShowListController.swift
//  TVShowManager
//
//  Created by Sourabh Singh on 13/09/21.
//

import Foundation
import UIKit
import Carbon
import Cartography
import Parse

class ShowTVShowListController: UIViewController {

    private var tvShows = [TVShow]() {
        didSet {
            renderer.render(makeSections())
        }
    }

    private var activityIndicator = UIActivityIndicatorView(style: .large)

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.allowsSelection = false
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .tertiarySystemGroupedBackground
        return tableView
    }()

    public let renderer = Renderer(
        adapter: UITableViewAdapter(),
        updater: UITableViewUpdater()
    )
    
    // MARK: Initialization
    init() {
        super.init(nibName: nil, bundle: nil)
        title = NSLocalizedString("TV Show List", comment: "Title string")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        Cartography.constrain(tableView, activityIndicator) {
            $0.edges == $0.superview!.edges
            $1.width == 100
            $1.height == 100
            $1.centerX == $1.superview!.centerX
            $1.centerY == $1.superview!.centerY
        }
    }

    override func viewDidLoad() {
        activityIndicator.startAnimating()
        renderer.target = tableView
        retrieveTVShows()
    }
    
    private func retrieveTVShows() {
        let query = TVShow.query()
        query?.findObjectsInBackground(block: { [weak self] shows, error in
            self?.activityIndicator.stopAnimating()
            if error == nil {
                if let shows = shows as? [TVShow] {
                    self?.tvShows = shows
                }
            }
        })
    }
}

extension ShowTVShowListController {
    func makeSections() -> [Section] {
        var cells = [CellNode]()
        for show in tvShows {
            let tvShowComponent = TVShowViewItemComponent(tvShow: show)
            cells.append(CellNode(id: "cell", tvShowComponent))
        }
        return [Section(id: "TVShowListComponents", cells: cells)]
    }
}

extension UIView {
    func addHomeDropShadow() {
        backgroundColor = UIColor.clear
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.1
        layer.masksToBounds = false
    }
}
