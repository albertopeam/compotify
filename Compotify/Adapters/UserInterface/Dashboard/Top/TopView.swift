//
//  TopView.swift
//  Compotify
//
//  Created by Alberto Penas Amor on 10/01/2020.
//  Copyright © 2020 com.github.albertopeam. All rights reserved.
//

import SwiftUI
import Combine

//TODO: refresh if error o needed
struct TopView: View {

    //TODO: make injections
    @ObservedObject var viewModel: TopViewModel = .init()

    var body: some View {
        switch viewModel.state {
        case .initial:
            return initial
        case .loading:
            return loading
        case let .success(items):
            return success(items)
        case .error:
            return error
        }
        //TODO: think what todo next
        //artists & tracks???
        //start with artists?
        // publisher with the data...(not filtered...)
        // artist model
        // then we can go with(maybe with some buttons in the layout..., maybe top tracks(to listen) & related to discover)
        // top tracks for artist https://developer.spotify.com/documentation/web-api/reference/artists/get-artists-top-tracks/
        // albums for artist https://developer.spotify.com/documentation/web-api/reference/artists/get-artists-albums/
        // related artists https://developer.spotify.com/documentation/web-api/reference/artists/get-related-artists/
    }

    private var initial: AnyView {
        AnyView(Text("").onAppear(perform: { self.viewModel.get() }))
    }

    private var loading: AnyView {
        AnyView(SpinnnerView())
    }

    private func success(_ items: [ArtistDecorator]) -> AnyView {
        AnyView(
            NavigationView {
                ScrollView(.horizontal, showsIndicators: false) {
                     HStack {
                        ForEach(items) { item in
                            VStack {
                                Text(item.name)                            
                                URLImage(url: item.image)
                                    .frame(width: CGFloat(320), height: CGFloat(320))
                            }
                         }
                     }
                }
            }
        )
    }

    private var error: AnyView {
        AnyView(Text("Something went wrong..."))
    }
}

struct TopView_Previews: PreviewProvider {
    static var previews: some View {
        TopView()
    }
}
