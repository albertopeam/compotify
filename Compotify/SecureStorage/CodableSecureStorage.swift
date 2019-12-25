//
//  CodableKeychain.swift
//  Compotify
//
//  Created by Alberto Penas Amor on 22/12/2019.
//  Copyright © 2019 com.github.albertopeam. All rights reserved.
//

import Foundation
import Combine

class CodableSecureStorage<T: Codable> {
    private let secureStorage: SecureStorage
    private var subscriptions = Set<AnyCancellable>()
    private let _publisher: PassthroughSubject<T?, Never>
    var publisher: AnyPublisher<T?, Never> { return _publisher.eraseToAnyPublisher() }
    var value: T? {
        get {
            do {
                return try fetch()
            } catch let error as SecureStorage.Error {
                switch error {
                case .noData: return nil
                case .unexpectedData, .unhandledError: throwError(error)
                }
            } catch {
                throwError(error)
            }
            return nil
        }
        set {
            if let toStore = newValue {
                do {
                    try store(codable: toStore)
                    _publisher.send(toStore)
                } catch {
                    throwError(error)
                }
            } else {
                do {
                    try delete()
                    _publisher.send(nil)
                } catch {
                    throwError(error)
                }
            }
        }
    }
    
    init(secureStorage: SecureStorage) {
        self.secureStorage = secureStorage
        self._publisher = .init()
    }
    
    private func store(codable: T) throws {
        let encoder = JSONEncoder()
        let data = try encoder.encode(codable)
        try secureStorage.store(data: data)
    }
    
    private func fetch() throws -> T {
        let data = try secureStorage.fetch()
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
    
    private func delete() throws {
        try secureStorage.delete()
    }

    private func throwError(_ error: Error) {
        fatalError("Something went wrong... \(error.localizedDescription)")
    }
    
}
