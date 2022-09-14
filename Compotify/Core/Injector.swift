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

class Injector {

    private var dependencies: [String: () -> Any] = .init()

    fileprivate func register(key: String, resolver: @escaping () -> Any) {
        dependencies[key] = resolver
    }

    func resolve<T>(type: T.Type) -> T {
        let key = String(describing: type)
        guard let candidate = dependencies.first(where: { $0.key == key }) else {
            fatalError("Dependency for \(key) couldn't be resolved")
        }
        let resolver = candidate.value()
        guard let dependency = resolver as? T else {
            fatalError("Dependency for \(key) couldn't be casted to \(T.self)")
        }
        return dependency
    }
}

class Demo {
    //TODO: migrate to class or struct based and create a proto, the idea is to have static and non static stuff
    here!!!
    func run() {
        let injector = Injector()
        let key = String(describing: NetworkPort.self)
        injector.register(key: key, resolver: {
            NetworkAdapter()
        })
        let networkPort = injector.resolve(type: NetworkPort.self)
        print("")
    }
}
