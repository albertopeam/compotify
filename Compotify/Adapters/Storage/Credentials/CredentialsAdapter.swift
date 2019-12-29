//
//  Credentials.swift
//  Compotify
//
//  Created by Alberto Penas Amor on 25/12/2019.
//  Copyright © 2019 com.github.albertopeam. All rights reserved.
//

import Foundation

class CredentialsAdapter: CredentialsPort {

    private let fileName: String
    var credentials: (clientId: String, redirectUri: String) {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "plist"),
            let xml = FileManager.default.contents(atPath: path),
            let credential = try? PropertyListDecoder().decode(CredentialCodable.self, from: xml) else {
                fatalError("Couldn't decode \(fileName)")
        }
        return (clientId: credential.clientId, redirectUri: credential.redirectUri)
    }

    init(fileName: String = "SpotifyCredentials") {
        self.fileName = fileName
    }

    private struct CredentialCodable: Codable {
        let clientId: String
        let redirectUri: String
    }

}
