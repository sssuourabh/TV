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
import Combine

class ShowTVShowListController: UIViewController {

    // MARK: Properties
    private var tvShows = [TVShow]() {
        didSet {
            renderer.render(makeSections())
        }
    }

    private var activityIndicator = UIActivityIndicatorView(style: .large)

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.allowsSelection = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .tertiarySystemGroupedBackground
        return tableView
    }()

    public let renderer = Renderer(
        adapter: UITableViewAdapter(),
        updater: UITableViewUpdater()
    )
    private var subscriptions: Set<AnyCancellable> = []
    public let client: GetDataClient
    
    // MARK: Initialization
    init(client: GetDataClient) {
        self.client = client
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
        client.getAllTVShows()
            .sink { [weak self] completion in
                self?.activityIndicator.stopAnimating()
                switch completion {
                case .failure(let error):
                    self?.showErrorView(error: error as NSError)
                case .finished:
                    break
                }
            } receiveValue: { [weak self] tvShows in
                self?.tvShows = tvShows
            }.store(in: &subscriptions)
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
