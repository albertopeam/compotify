//
//  AuthenticationView.swift
//  Compotify
//
//  Created by Alberto Penas Amor on 25/12/2019.
//  Copyright © 2019 com.github.albertopeam. All rights reserved.
//

import SwiftUI

struct AuthenticationView: View {
    @ObservedObject private var viewModel: AuthenticationViewModel
    @State private var isLoading: Bool = true

    init(viewModel: AuthenticationViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        switch viewModel.state {
        case .load(let request):
            return ZStack {
                WebView(isLoading: $isLoading, urlPublisher: viewModel.urlPublisher, request: request)
                SpinnnerView(isAnimating: $isLoading)
            }
        }
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        return AuthenticationAssembler.assemble(authentication: AuthenticationAssembler.assembleAuthentication())
    }
}
