//
//  CredentialsAdapterTests.swift
//  CompotifyTests
//
//  Created by Alberto Penas Amor on 29/12/2019.
//  Copyright © 2019 com.github.albertopeam. All rights reserved.
//

@testable import Compotify
import XCTest

class CredentialsAdapterTests: XCTestCase {
    
    func testGivenDefaultCrendetialsWhenGetThenMatchNotEmpty() {
        let sut = CredentialsAdapter()
        let credentials = sut.credentials
        XCTAssertFalse(credentials.clientId.isEmpty)
        XCTAssertFalse(credentials.redirectUri.isEmpty)
    }


}
