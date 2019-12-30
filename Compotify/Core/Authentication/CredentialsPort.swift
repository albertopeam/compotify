//
//  CredentialsPort.swift
//  Compotify
//
//  Created by Alberto Penas Amor on 25/12/2019.
//  Copyright © 2019 com.github.albertopeam. All rights reserved.
//

import Foundation

protocol CredentialsPort {
    var credentials: (clientId: String, redirectUri: String) { get }
}
