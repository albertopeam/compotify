//
//  Network.swift
//  Compotify
//
//  Created by Alberto Penas Amor on 25/12/2019.
//  Copyright © 2019 com.github.albertopeam. All rights reserved.
//

import Foundation
import Combine

class NetworkAdapter: NetworkPort {
    private let session: URLSession
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

    init(session: URLSession = .shared) {
        self.session = session
    }

    // MARK: - auth

    func authentication(_ credentials: (clientId: String, redirectUri: String)) -> URLRequest {
        let clientId = credentials.clientId
        let redirectUri = credentials.redirectUri
        let responseType = "token"
        let scopes = "user-read-email user-read-private user-top-read".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let redirect = redirectUri.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let state = "compotify"
        let url = URL(string: "https://accounts.spotify.com/authorize?client_id=\(clientId)&response_type=\(responseType)&redirect_uri=\(redirect)&state=\(state)&scope=\(scopes)")!
        return URLRequest(url: url)
    }

    // MARK: - me/top

    func myTopArtists(token: String?) -> AnyPublisher<[Artist], DataError> {
        let url = URL(string: "\(endpoint)/me/top/artists?limit=50&offset=0&time_range=short_term")!
        let request = buildRequest(for: url, accessToken: token)
        return session.dataTaskPublisher(for: request)
            .tryMap({ try self.mapOrThrow(data: $0, response: $1)})
            .decode(type: ArtistsResponse.self, decoder: JSONDecoder())
            .map({ self.mapArtists($0.items) })
            .mapError({ self.mapError(error: $0) })
            .eraseToAnyPublisher()
    }

    // MARK: - artists

    private func mapArtists(_ input: [ArtistsResponse.Artist]) -> [Artist] {
        return input.map({ Artist(id: $0.id, name: $0.name, followers: $0.followers.total, genres: $0.genres, image: mapImage($0.images), popularity: $0.popularity) })
    }

    private func mapImage(_ input: [Image]) -> URL? {
        if input.count > 1 {
            return URL(string: input.dropFirst().first?.url)
        }
        return URL(string: input.first?.url)
    }

    // MARK: private

    private func buildRequest(for url: URL, accessToken: String?) -> URLRequest {
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = ["Authorization": "Bearer \(accessToken ?? "")"]
        return request
    }

    func mapOrThrow(data: Data?, response: URLResponse?) throws -> Data {
        guard let httpResponse = response as? HTTPURLResponse, let data = data else {
            throw NetworkError(statusCode: nil, data: nil)
        }
        if httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 {
            return data
        }
        throw NetworkError(statusCode: httpResponse.statusCode, data: data)
    }

    func mapError(error: Error) -> DataError {
        if let err = error as? NetworkError {
            if err.statusCode == 401 {
                return .authentication
            }
        }
        return .source
    }
}

// MARK: - error

private struct NetworkError: Error {
    let statusCode: Int?
    let data: Data?
}

// MARK: - structs

private struct ArtistsResponse: Decodable {
    let items: [Artist]
    struct Artist: Decodable {
        let followers: Followers
        let genres: [String]
        let href: String
        let id: String
        let images: [Image]
        let name: String
        let popularity: Int
        let uri: String
    }
    struct Followers: Decodable {
        let total: Int
    }
}

private struct Image: Decodable {
    let height: Int
    let url: String
    let width: Int
}
