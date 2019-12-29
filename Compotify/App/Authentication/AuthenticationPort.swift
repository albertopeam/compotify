//
//  AuthenticationPort.swift
//  Compotify
//
//  Created by Alberto Penas Amor on 25/12/2019.
//  Copyright © 2019 com.github.albertopeam. All rights reserved.
//

import Foundation
import Combine

protocol AuthenticationPort {
    var token: String? { get set }
    var publisher: AnyPublisher<String?, Never> { get }
}
