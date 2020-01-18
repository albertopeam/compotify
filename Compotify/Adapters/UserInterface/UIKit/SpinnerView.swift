//
//  SpinnerView.swift
//  Compotify
//
//  Created by Alberto Penas Amor on 18/01/2020.
//  Copyright © 2020 com.github.albertopeam. All rights reserved.
//

import SwiftUI
import Foundation

struct SpinnnerView: UIViewRepresentable {
    private let spinner = UIActivityIndicatorView()

    func makeUIView(context: UIViewRepresentableContext<SpinnnerView>) -> UIActivityIndicatorView {
        spinner.startAnimating()
        spinner.tintColor = .gray
        spinner.hidesWhenStopped = true
        return spinner
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<SpinnnerView>) {}
}
