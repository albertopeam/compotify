//
//  AuthenticationAssembler.swift
//  Compotify
//
//  Created by Alberto Penas Amor on 26/12/2019.
//  Copyright © 2019 com.github.albertopeam. All rights reserved.
//

import Foundation

//TODO: move to DI
class AuthenticationAssembler {
    static func assembleAuthentication() -> Authentication {
        return Authentication(authPort: AuthenticationAdapter(),
                              credentialsPort: CredentialsAdapter(),
                              networkPort: NetworkAdapter())
    }

    static func assemble(authentication: Authentication) -> AuthenticationView {
        let viewModel = AuthenticationViewModel(authentication: authentication)
        return AuthenticationView(viewModel: viewModel)
    }
}
