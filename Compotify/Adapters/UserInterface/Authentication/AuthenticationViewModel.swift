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
    var authRequest: URLRequest { authentication.authenticationRequest }

    init(authentication: Authentication) {
        self.authentication = authentication
        urlPublisher
            .map({ authentication.authenticate(url: $0) })
            .sink(receiveValue: { _ in })
            .store(in: &subscriptions)
    }
}
