//
//  URLImage.swift
//  Compotify
//
//  Created by Alberto Penas Amor on 18/01/2020.
//  Copyright © 2020 com.github.albertopeam. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct URLImage: View {
    let url: URL?

    var body: some View {
        KFImage(url)
            .resizable()
            .placeholder {
                Image(systemName: "arrow.2.circlepath.circle")
                    .font(.largeTitle)
                    .opacity(0.3)
            }
            .aspectRatio(contentMode: .fit)            
    }


}
