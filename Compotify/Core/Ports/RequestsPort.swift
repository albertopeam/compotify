//
//  RequestsPort.swift
//  Compotify
//
//  Created by Alberto Penas Amor on 25/12/2019.
//  Copyright © 2019 com.github.albertopeam. All rights reserved.
//

import Foundation

//TODO: maybe is not a port...
protocol RequestsPort {
    func authentication(_ credentials: (clientId: String, redirectUri: String)) -> URLRequest
}
