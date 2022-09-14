//
//  NetworkPort.swift
//  Compotify
//
//  Created by Alberto Penas Amor on 25/12/2019.
//  Copyright © 2019 com.github.albertopeam. All rights reserved.
//

import Foundation
import Combine

protocol NetworkPort {
    func authentication(_ credentials: (clientId: String, redirectUri: String)) -> URLRequest
    func myTopArtists(token: String?) -> AnyPublisher<[Artist], DataError>
}
