//
//  HomeViewRouterImpl.swift
//  TVShowManager
//
//  Created by Sourabh Singh on 13/09/21.
//

import Foundation
import UIKit
import Combine
import Parse

public protocol HomeViewRouter {
    func presentListOfTVShowController(from: UIViewController)
    func presentAddTVShowController(from: UIViewController)
}

class HomeViewRouterImpl: HomeViewRouter {
    func presentListOfTVShowController(from: UIViewController) {
        let showListOfTVShows = ShowTVShowListController(client: GetDataCleintImpl())
        from.navigationController?.pushViewController(showListOfTVShows, animated: true)
    }
    
    func presentAddTVShowController(from: UIViewController) {
        let addTvShowController = AddTVShowController(client: SaveDataClientImpl())
        from.navigationController?.pushViewController(addTvShowController, animated: true)
    }
}
