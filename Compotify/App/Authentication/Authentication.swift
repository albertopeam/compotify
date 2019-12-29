//
//  Authentication.swift
//  Compotify
//
//  Created by Alberto Penas Amor on 25/12/2019.
//  Copyright © 2019 com.github.albertopeam. All rights reserved.
//

import Foundation
import Combine

class Authentication {
    private var authPort: AuthenticationPort
    private let credentialsPort: CredentialsPort
    private let requestsPort: RequestsPort

    init(authPort: AuthenticationPort,
         credentialsPort: CredentialsPort,
         requestsPort: RequestsPort) {
        self.authPort = authPort
        self.credentialsPort = credentialsPort
        self.requestsPort = requestsPort
    }

    var token: String? {
        return authPort.token
    }

    var authenticationRequest: URLRequest { requestsPort.authentication(credentialsPort.credentials) }

    var publisher: AnyPublisher<String?, Never> {
        return authPort.publisher
    }

    func authenticate(url: URL) -> Bool {
        if url.host == "compotify.com", let fragment = url.fragment {
            if let accessToken = fragment.components(separatedBy: "&")
                .filter({ $0.contains("access_token")})
                .map({ $0.replacingOccurrences(of: "access_token=", with: "") })
                .first {
                authPort.token = accessToken
                return true
            }
        }
        return false
    }
}
