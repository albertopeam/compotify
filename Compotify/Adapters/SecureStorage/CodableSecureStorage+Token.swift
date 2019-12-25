//
//  KeychainBuilder.swift
//  Compotify
//
//  Created by Alberto Penas Amor on 22/12/2019.
//  Copyright © 2019 com.github.albertopeam. All rights reserved.
//

extension CodableSecureStorage {
    static func tokenStorage() -> CodableSecureStorage<String> {
        let service: String = "secure-storage"
        let key: String = "token"
        let secureStorage = SecureStorage(group: nil, service: service, key: key)
        return CodableSecureStorage<String>(secureStorage: secureStorage)
    }
}
