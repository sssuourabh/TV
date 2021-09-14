//
//  GetDataClientImpl.swift
//  TVShowManager
//
//  Created by Sourabh Singh on 14/09/21.
//

import Foundation
import Combine
import Parse

public protocol GetDataClient {
    func getAllTVShows() -> AnyPublisher<[TVShow], Error>
}

class GetDataCleintImpl: GetDataClient {
    func getAllTVShows() -> AnyPublisher<[TVShow], Error> {
        let subject = PassthroughSubject<[TVShow], Error>()
        let query = TVShow.query()
        query?.findObjectsInBackground(block: { shows, error in
            if error == nil {
                if let shows = shows as? [TVShow] {
                    subject.send(shows)
                    subject.send(completion: .finished)
                }
            } else {
                subject.send(completion: .failure(error!))
            }
        })
        return subject.eraseToAnyPublisher()
    }
}
