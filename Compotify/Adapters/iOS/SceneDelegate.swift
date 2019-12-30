//
//  SceneDelegate.swift
//  Compotify
//
//  Created by Alberto Penas Amor on 22/12/2019.
//  Copyright © 2019 com.github.albertopeam. All rights reserved.
//

import UIKit
import SwiftUI
import Combine

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var subscriptions: Set<AnyCancellable> = .init()
    //TODO: DI -> Singleton...
    private let authentication: Authentication = AuthenticationAssembler.assembleAuthentication()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard NSClassFromString("XCTestCase") == nil else {
            return //TODO: https://marcosantadev.com/fake-appdelegate-unit-testing-swift/
        }

        func view(token: String?) -> AnyView {
            (token?.isEmpty ?? true) ?
            AnyView(AuthenticationAssembler.assemble(authentication: self.authentication)) :
            AnyView(DashboardView())
        }
        authentication.publisher
            .map({ view(token: $0) })
            .sink(receiveValue: { view in
                self.window?.rootViewController = UIHostingController(rootView: view) })
            .store(in: &subscriptions)

        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: view(token: authentication.token))
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}

