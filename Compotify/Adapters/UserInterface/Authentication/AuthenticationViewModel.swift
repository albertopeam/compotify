//
//  AuthenticationViewModel.swift
//  Compotify
//
//  Created by Alberto Penas Amor on 26/12/2019.
//  Copyright © 2019 com.github.albertopeam. All rights reserved.
//

import Foundation
import Combine

class AuthenticationViewModel: ObservableObject {
    private let authentication: Authentication
    private var subscriptions: Set<AnyCancellable> = .init()
    let urlPublisher: PassthroughSubject<URL, Never> = .init()
    @Published var state: AuthState
    //TODO: maybe expose url,,...

    init(authentication: Authentication) {
        self.authentication = authentication
        self.state = .load(authentication.authenticationRequest)
        urlPublisher
            .map({ authentication.authenticate(url: $0) })
            .filter({ $0 })
            .sink(receiveValue: { _ in })
            .store(in: &subscriptions)
    }

    enum AuthState: Equatable {
        case load(_ request: URLRequest)
    }
}
