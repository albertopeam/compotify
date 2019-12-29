//
//  WebView.swift
//  Compotify
//
//  Created by Alberto Penas Amor on 26/12/2019.
//  Copyright © 2019 com.github.albertopeam. All rights reserved.
//

import SwiftUI
import WebKit
import Combine

struct WebView: UIViewRepresentable {

    private let webView = WKWebView()
    @Binding var isLoading: Bool
    let urlPublisher: PassthroughSubject<URL, Never>
    let request: URLRequest

    func makeCoordinator() -> Coordinator {
        Coordinator(wkWebView: webView, webView: self)
    }

    func makeUIView(context: UIViewRepresentableContext<WebView>) -> WKWebView {
        webView.load(request)
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<WebView>) {}

    class Coordinator: NSObject, WKNavigationDelegate {

        private let webView: WebView

        init(wkWebView: WKWebView, webView: WebView) {
            self.webView = webView
            super.init()
            wkWebView.navigationDelegate = self
        }

        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            guard let url = navigationAction.request.url else { return }
            decisionHandler(.allow)
            self.webView.urlPublisher.send(url)
        }

        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            self.webView.isLoading = true
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            self.webView.isLoading = false
        }
    }
}
