//
//  RequestsAdapterTests.swift
//  CompotifyTests
//
//  Created by Alberto Penas Amor on 30/12/2019.
//  Copyright © 2019 com.github.albertopeam. All rights reserved.
//

@testable import Compotify
import XCTest

class RequestsAdapterTests: XCTestCase {

    func testGivenAuthRequestWhenGetMatchUrlAndPathAndParams() throws {
        let sut = NetworkAdapter()
        let request = sut.authentication((clientId: "id", redirectUri: "uri"))
        XCTAssertEqual(request.httpMethod, "GET")
        let url = try XCTUnwrap(request.url)
        XCTAssertEqual(url.host, "accounts.spotify.com")
        XCTAssertEqual(url.path, "/authorize")
        let query = try XCTUnwrap(request.url?.query)
        XCTAssertTrue(query.contains("client_id=id"))
        XCTAssertTrue(query.contains("redirect_uri=uri"))
        XCTAssertTrue(query.contains("state=compotify"))
        XCTAssertTrue(query.contains("scope=user-read-email%20user-read-private"))
        XCTAssertTrue(query.contains("response_type=token"))
    }

}
