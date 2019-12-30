//
//  AuthenticationViewModelTests.swift
//  CompotifyTests
//
//  Created by Alberto Penas Amor on 30/12/2019.
//  Copyright © 2019 com.github.albertopeam. All rights reserved.
//

@testable import Compotify
import XCTest
import Combine

class AuthenticationViewModelTests: XCTestCase {

    private var authMock: AuthenticationMock!
    private var sut: AuthenticationViewModel!

    override func setUp() {
        authMock = .init()
        sut = .init(authentication: authMock)
    }

    override func tearDown() {
        authMock = nil
        sut = nil
        super.tearDown()
    }

    func testGivenSomeUrlWhenSendedToPublisherThenMatchAsProcessed() throws {
        let url = try XCTUnwrap(URL(string: "callback"))
        sut.urlPublisher.send(url)
        XCTAssertTrue(authMock.invokedAuthenticate)
    }

}

private class AuthenticationMock: Authentication {
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


