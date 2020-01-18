//
//  TopViewModel.swift
//  Compotify
//
//  Created by Alberto Penas Amor on 18/01/2020.
//  Copyright © 2020 com.github.albertopeam. All rights reserved.
//

import Foundation
import Combine

//TODO: move out of here
class TopViewModel: ObservableObject {
    enum State: Equatable {
        case initial
        case loading
        case success(_ artists: [ArtistDecorator])
        case error
        static func == (lhs: TopViewModel.State, rhs: TopViewModel.State) -> Bool {
            switch (lhs, rhs) {
            case (.initial, .initial): return true
            case (.loading, .loading): return true
            case let (.success(lhsArt), .success(rhsArt)): return lhsArt == rhsArt
            case (.error, .error): return true
            default: return false
            }
        }
    }
    @Published var state: State
    private let networkAdapter: NetworkAdapter = .init()
    private let authPort: AuthenticationPort = AuthenticationAdapter()
    private var subscriptions = Set<AnyCancellable>()

    init() {
        self.state = .initial
    }

    func get() {
        self.state = .loading
        networkAdapter.myTopArtists(token: authPort.token)
            .map({ $0.map({ ArtistDecorator($0) }) })
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: {
                switch $0 {
                    case .finished: break
                    case .failure(_): self.state = .error //TODO: handle 401
                }
            }, receiveValue: { self.state = .success($0) })
            .store(in: &subscriptions)
    }
}
