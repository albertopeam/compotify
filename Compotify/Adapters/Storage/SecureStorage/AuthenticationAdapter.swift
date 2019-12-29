//
//  KeychainBuilder.swift
//  Compotify
//
//  Created by Alberto Penas Amor on 22/12/2019.
//  Copyright © 2019 com.github.albertopeam. All rights reserved.
//
import Combine

class AuthenticationAdapter: AuthenticationPort {
    var token: String? {
        get {
            secureStorage.value
        }
        set {
            secureStorage.value = newValue
        }
    }
    var publisher: AnyPublisher<String?, Never> {
        return secureStorage.publisher
    }

    private let secureStorage: CodableSecureStorage<String>

    init() {
        let service: String = "secure-storage"
        let key: String = "token"
        let secureStorage = SecureStorage(group: nil, service: service, key: key)
        self.secureStorage = CodableSecureStorage<String>(secureStorage: secureStorage)
    }
}
