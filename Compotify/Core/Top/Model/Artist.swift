//
//  Artist.swift
//  Compotify
//
//  Created by Alberto Penas Amor on 12/01/2020.
//  Copyright © 2020 com.github.albertopeam. All rights reserved.
//

import Foundation

struct Artist {
    let id: String
    let name: String
    let followers: Int
    let genres: [String]
    let image: URL?
    let popularity: Int
}
