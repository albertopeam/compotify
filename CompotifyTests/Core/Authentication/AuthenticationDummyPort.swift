//
//  AuthenticationDummyPort.swift
//  CompotifyTests
//
//  Created by Alberto Penas Amor on 30/12/2019.
//  Copyright © 2019 com.github.albertopeam. All rights reserved.
//

@testable import Compotify
import Combine
import Foundation

class AuthenticationDummyPort: AuthenticationPort {
    var token: String? {
        get {
            fatalError()
        }
        set {
            fatalError()
        }
    }

    var publisher: AnyPublisher<String?, Never> {
        fatalError()
    }
}
