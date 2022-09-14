//
//  Top.swift
//  Compotify
//
//  Created by Alberto Penas Amor on 18/01/2020.
//  Copyright © 2020 com.github.albertopeam. All rights reserved.
//

import Foundation
import Combine

class Top {
    private let networkPort: NetworkPort
    private var authPort: AuthenticationPort

    init(networkPort: NetworkPort, authPort: AuthenticationPort) {
        self.networkPort = networkPort
        self.authPort = authPort
    }

    //TODO: test this!!!!
    func myTop() -> AnyPublisher<[Artist], DataError> {
        return networkPort
            .myTopArtists(token: authPort.token)
            .handleEvents(receiveCompletion: {
                switch $0 {
                case .finished: break
                case let .failure(error):
                    switch error {
                    case .authentication:
                        self.authPort.token = nil
                    default:
                        break
                    }
                }
            })
            .eraseToAnyPublisher()
    }
}
