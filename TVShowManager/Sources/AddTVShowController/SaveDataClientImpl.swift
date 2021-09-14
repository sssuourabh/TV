//
//  SaveDataClientImpl.swift
//  TVShowManager
//
//  Created by Sourabh Singh on 14/09/21.
//

import Foundation
import Combine
import Parse

public protocol SaveDataClient {
    func saveTVShow(tvShow: TVShow) -> AnyPublisher<Void, Error>
}

class SaveDataClientImpl: SaveDataClient {
    func saveTVShow(tvShow: TVShow) -> AnyPublisher<Void, Error> {
        let subject = PassthroughSubject<Void, Error>()
        tvShow.saveInBackground { (succeeded, error) in
            if error == nil {
                subject.send(())
                subject.send(completion: .finished)
            } else {
                subject.send(completion: .failure(error!))
            }
        }
        return subject.eraseToAnyPublisher()
    }
}
