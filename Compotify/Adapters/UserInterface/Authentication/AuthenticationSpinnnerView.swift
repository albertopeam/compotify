//
//  SpinnnerView.swift
//  Compotify
//
//  Created by Alberto Penas Amor on 26/12/2019.
//  Copyright © 2019 com.github.albertopeam. All rights reserved.
//

import SwiftUI

struct AuthenticationSpinnnerView: UIViewRepresentable {

    @Binding var isAnimating: Bool
    private let spinner = UIActivityIndicatorView()

    func makeUIView(context: UIViewRepresentableContext<AuthenticationSpinnnerView>) -> UIActivityIndicatorView {
        spinner.tintColor = .gray
        spinner.hidesWhenStopped = true
        return spinner
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<AuthenticationSpinnnerView>) {
        if isAnimating {
            spinner.startAnimating()
        } else {
            spinner.stopAnimating()
        }
    }
}
