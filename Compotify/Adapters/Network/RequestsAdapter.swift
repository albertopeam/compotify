//
//  Network.swift
//  Compotify
//
//  Created by Alberto Penas Amor on 25/12/2019.
//  Copyright © 2019 com.github.albertopeam. All rights reserved.
//

import Foundation

class RequestsAdapter: RequestsPort {
    private let endpoint = "https://api.spotify.com/v1"
    private var locale: String {
        return Locale.current.languageCode ?? "es"
    }
    private var country: String {
        return Locale.current.regionCode ?? "es"
    }
    private var timestamp: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let now = Date()
        return dateFormatter.string(from: now)
    }

    // MARK: - auth

    func authentication(_ credentials: (clientId: String, redirectUri: String)) -> URLRequest {
        let clientId = credentials.clientId
        let redirectUri = credentials.redirectUri
        let responseType = "token"
        let scopes = "user-read-email user-read-private".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let redirect = redirectUri.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let state = "compotify"
        let url = URL(string: "https://accounts.spotify.com/authorize?client_id=\(clientId)&response_type=\(responseType)&redirect_uri=\(redirect)&state=\(state)&scope=\(scopes)")!
        return URLRequest(url: url)
    }
}
