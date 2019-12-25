//
//  CodableSecureStorageTests.swift
//  CompotifyTests
//
//  Created by Alberto Penas Amor on 24/12/2019.
//  Copyright © 2019 com.github.albertopeam. All rights reserved.
//

import XCTest
import Combine
@testable import Compotify

class CodableSecureStorageTests: XCTestCase {

    private var storage: SecureStorage!
    private var subscriptions: Set<AnyCancellable> = []
    private var sut: CodableSecureStorage<String>!

    override func setUp() {
        storage = SecureStorage(group: nil, service: "demo", key: "string")
        do {
            try storage.delete()
        } catch {
            fatalError()
        }
        subscriptions = []
        sut = .init(secureStorage: storage)
    }

    override func tearDown() {
        do {
            try storage.delete()
        } catch {
            fatalError()
        }
        subscriptions = []
        storage = nil
        sut = nil
        super.tearDown()
    }

    // MARK: - value

    func testGivenEmptyStorageWhenGetValueThenMatchNil() {
        XCTAssertNil(sut.value)
    }

    func testGivenNotEmptyStorageWhenSendNilValueThenMatchStored() {
        let token = "token"
        sut.value = token
        sut.value = nil
        XCTAssertNil(sut.value)
    }

    // MARK: - publisher

    func testGivenEmptyStorageWhenSendValueThenPublishAsExpected() {
        let token = "token"

        var value: String? = ""
        sut.publisher
            .sink(receiveValue: { value = $0 })
            .store(in: &subscriptions)
        sut.value = token

        XCTAssertEqual(value, token)
    }

    func testGivenNotEmptyStorageWhenSendNilValueThenPublishAsExpected() {
        let token = "token"
        sut.value = token

        var value: String? = ""
        sut.publisher
            .sink(receiveValue: { value = $0 })
            .store(in: &subscriptions)
        sut.value = nil

        XCTAssertNil(value)
    }

}
