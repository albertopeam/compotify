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
    //TODO: think what todo next
    //artists & tracks???
    //start with artists?
    // publisher with the data...(not filtered...)
    // artist model
    // then we can go with(maybe with some buttons in the layout..., maybe top tracks(to listen) & related to discover)
    // top tracks for artist https://developer.spotify.com/documentation/web-api/reference/artists/get-artists-top-tracks/
    // albums for artist https://developer.spotify.com/documentation/web-api/reference/artists/get-artists-albums/
    // related artists https://developer.spotify.com/documentation/web-api/reference/artists/get-related-artists/
    @ObservedObject var viewModel: TopViewModel

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
                VStack() {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .top) {
                            ForEach(items) { item in
                                VStack {
                                    Text(item.name)
                                    URLImage(url: item.image)
                                        .frame(width: CGFloat(320), height: CGFloat(320))
                                }
                             }
                        }
                    }
                    Spacer()
                }
                .navigationBarTitle("My Top")
            }
        )
    }

    private var error: AnyView {
        AnyView(
            VStack {
                Text("Something went wrong...")
                Spacer().frame(height: 10)
                Button(action: { self.viewModel.get() }, label: { Text("Retry") })
            }
        )
    }
}

struct TopView_Previews: PreviewProvider {
    private static let artists: [ArtistDecorator] = [
        .init(Artist(id: "0", name: "Brookes Brothers", followers: 30810, genres: ["drum and bass", "jump up", "liquid funk", "uk dnb"], image: URL(string: "https://i.scdn.co/image/64e3f67ce9b96c55d1a398f0b22f219b48b276d0"), popularity: 50)),

        .init(Artist(id: "1", name: "Chillout Sound Festival", followers: 4166, genres: [], image: URL(string: "https://i.scdn.co/image/ab67616d00001e0251bf70ff86855c49345f330a"), popularity: 39))
    ]

    static var previews: some View {
        Group {
            TopView(viewModel: .init(state: .loading))
                .previewDisplayName("Loading")
            TopView(viewModel: .init(state: .error))
                .previewDisplayName("Error")
            TopView(viewModel: .init(state: .success(artists)))
                .previewDisplayName("Success")
        }
    }
}
