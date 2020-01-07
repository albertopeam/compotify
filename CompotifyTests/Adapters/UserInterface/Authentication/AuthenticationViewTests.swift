//
//  AuthenticationViewTests.swift
//  CompotifyTests
//
//  Created by Alberto Penas Amor on 30/12/2019.
//  Copyright © 2019 com.github.albertopeam. All rights reserved.
//

@testable import Compotify
import XCTest
import Combine
import ViewInspector

extension AuthenticationView: Inspectable {}
extension WebView: Inspectable {}
extension SpinnnerView: Inspectable {}

class AuthenticationViewTests: XCTestCase {

    private var viewModelMock: AuthViewModelMock!
    private var sut: AuthenticationView!

    override func setUp() {
        super.setUp()
        viewModelMock = .init()
        sut = AuthenticationView(viewModel: viewModelMock)
    }

    override func tearDown() {
        viewModelMock = nil
        sut = nil
        super.tearDown()
    }

    func testWhenLoadedThenMatchLoadingState() throws {
        let body = try sut
            .inspect()
            .view(AuthenticationView.self)
            .zStack()
        let webview = try body.view(WebView.self, 0).actualView()
        let spinner = try body.view(SpinnnerView.self, 1).actualView()
        XCTAssertNotNil(body)
        XCTAssertEqual(webview.request, viewModelMock.authRequest)
        XCTAssertTrue(spinner.isAnimating)
    }
}

private class AuthViewModelMock: AuthenticationViewModel {
    override var authRequest: URLRequest { .init(url: URL(string: "some")!) }
    init() {
        super.init(authentication: AuthenticationMock())
    }
}
