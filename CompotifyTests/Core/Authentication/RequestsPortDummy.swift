//
//  RequestsPortDummy.swift
//  CompotifyTests
//
//  Created by Alberto Penas Amor on 30/12/2019.
//  Copyright © 2019 com.github.albertopeam. All rights reserved.
//

@testable import Compotify
import Foundation

class RequestsPortDummy: RequestsPort {
    func authentication(_ credentials: (clientId: String, redirectUri: String)) -> URLRequest {
        fatalError()
    }
}
