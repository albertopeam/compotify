//
//  AuthenticationMock.swift
//  CompotifyTests
//
//  Created by Alberto Penas Amor on 30/12/2019.
//  Copyright © 2019 com.github.albertopeam. All rights reserved.
//

@testable import Compotify
import Foundation

class AuthenticationMock: Authentication {
    var authRequest: URLRequest!
    var invokedAuthenticate: Bool!

    init() {
        super.init(authPort: AuthenticationDummyPort(),
                   credentialsPort: CredentialsPortDummy(),
                   requestsPort: RequestsPortDummy())
    }

    override var authenticationRequest: URLRequest { URLRequest(url: URL(string: "some")!) }

    override func authenticate(url: URL) -> Bool {
        invokedAuthenticate = true
        return false
    }
}
