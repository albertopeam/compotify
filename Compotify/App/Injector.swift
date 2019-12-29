//
//  Injector.swift
//  Compotify
//
//  Created by Alberto Penas Amor on 25/12/2019.
//  Copyright © 2019 com.github.albertopeam. All rights reserved.
//

//TODO: boom!!!
//https://basememara.com/swift-dependency-injection-via-property-wrapper/
import Foundation

//TODO: acabar el injector...
//TODO: ver si esto compensa...como voy a enganchar el viewModel y la view y el core
class Injector {

    private var types: [String: () -> Any] = .init()

    func register() {
        fatalError()
    }

    func resolve<T>(type: T.Type) -> T {
        fatalError()
    }
}
