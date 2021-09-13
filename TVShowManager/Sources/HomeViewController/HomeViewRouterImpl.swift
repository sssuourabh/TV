//
//  HomeViewRouterImpl.swift
//  TVShowManager
//
//  Created by Sourabh Singh on 13/09/21.
//

import Foundation
import UIKit

public protocol HomeViewRouter {
    func presentListOfTVShowController(from: UIViewController)
    func presentAddTVShowController(from: UIViewController)
}

class HomeViewRouterImpl: HomeViewRouter {
    func presentListOfTVShowController(from: UIViewController) {
        let showListOfTVShows = ShowTVShowListController()
        from.navigationController?.pushViewController(showListOfTVShows, animated: true)
    }
    
    func presentAddTVShowController(from: UIViewController) {
        let addTvShowController = AddTVShowController()
        from.navigationController?.pushViewController(addTvShowController, animated: true)
    }
}
