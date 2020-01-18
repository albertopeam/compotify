//
//  ArtistDecorator.swift
//  Compotify
//
//  Created by Alberto Penas Amor on 15/01/2020.
//  Copyright © 2020 com.github.albertopeam. All rights reserved.
//

import Foundation

struct ArtistDecorator: Identifiable, Equatable {
    let id: String
    let name: String
    let genres: String
    let image: URL?
    let popularity: String

    init(_ artist: Artist) {
        self.id = artist.id
        self.name = artist.name
        self.genres = artist.genres.joined(separator: ", ")
        self.image = artist.image
        self.popularity = String(artist.popularity)
    }
}
