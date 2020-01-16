//
//  URL+Optional.swift
//  Compotify
//
//  Created by Alberto Penas Amor on 14/01/2020.
//  Copyright © 2020 com.github.albertopeam. All rights reserved.
//

import Foundation

extension URL {
    init?(string: String?) {
        if let string = string {
            self.init(string: string)
            return
        }
        return nil
    }
}
