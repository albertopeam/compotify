//
//  AuthenticationTests.swift
//  CompotifyTests
//
//  Created by Alberto Penas Amor on 30/12/2019.
//  Copyright © 2019 com.github.albertopeam. All rights reserved.
//

@testable import Compotify
import Combine
import XCTest

class AuthenticationTests: XCTestCase {

    private var authPortSpy: AuthenticationPortSpy!
    private var sut: Authentication!

    override func setUp() {
        super.setUp()
        authPortSpy = AuthenticationPortSpy()
        sut = Authentication(authPort: authPortSpy,
                             credentialsPort: CredentialsPortDummy(),
                             requestsPort: RequestsPortDummy())
    }

    override func tearDown() {
        super.tearDown()
        authPortSpy = nil
        sut = nil
    }

    func testGivenInvalidCallbackUrlWhenTryToAuthenticateThenReturnFalse() throws {
        let url = try XCTUnwrap(URL(string: "https://another-host.com/callback#access_token=demo&token_type=Bearer&expires_in=3600&state=compotify"))
        XCTAssertFalse(sut.authenticate(url: url))
        XCTAssertNil(authPortSpy.spiedToken)
    }

    func testGivenValidCallbackUrlButNoTokenWhenTryToAuthenticateThenReturnFalse() throws {
        let url = try XCTUnwrap(URL(string: "https://compotify.com/callback#token_type=Bearer&expires_in=3600&state=compotify"))
        XCTAssertFalse(sut.authenticate(url: url))
        XCTAssertNil(authPortSpy.spiedToken)
    }

    func testGivenValidCallbackUrlWhenTryToAuthenticateThenReturnTrue() throws {
        let url = try XCTUnwrap(URL(string: "https://compotify.com/callback#access_token=demo&token_type=Bearer&expires_in=3600&state=compotify"))
        XCTAssertTrue(sut.authenticate(url: url))
        XCTAssertEqual(authPortSpy.spiedToken, "demo")
    }

}

private class AuthenticationPortSpy: AuthenticationPort {
    var spiedToken: String?

    var token: String? {
        get {
            fatalError()
        }
        set {
            spiedToken = newValue
        }
    }

    var publisher: AnyPublisher<String?, Never> {
        fatalError()
    }
}
