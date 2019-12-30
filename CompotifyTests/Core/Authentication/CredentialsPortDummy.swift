//
//  CredentialsPortDummy.swift
//  CompotifyTests
//
//  Created by Alberto Penas Amor on 30/12/2019.
//  Copyright © 2019 com.github.albertopeam. All rights reserved.
//

@testable import Compotify
import Foundation

class CredentialsPortDummy: CredentialsPort {
    var credentials: (clientId: String, redirectUri: String) {
        fatalError()
    }
}
