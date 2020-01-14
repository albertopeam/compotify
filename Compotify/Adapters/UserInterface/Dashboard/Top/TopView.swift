//
//  TopView.swift
//  Compotify
//
//  Created by Alberto Penas Amor on 10/01/2020.
//  Copyright © 2020 com.github.albertopeam. All rights reserved.
//

import SwiftUI
import Combine

struct TopView: View {

    //TODO: make injections
    @ObservedObject var viewModel: TopViewModel = .init()
    
    var body: some View {
        Text("First View")
        //artists & tracks???
        //start with artists?
        // publisher with the data...(not filtered...)
        // artist model
        // then we can go with(maybe with some buttons in the layout..., maybe top tracks(to listen) & related to discover)
        // top tracks for artist https://developer.spotify.com/documentation/web-api/reference/artists/get-artists-top-tracks/
        // albums for artist https://developer.spotify.com/documentation/web-api/reference/artists/get-artists-albums/
        // related artists https://developer.spotify.com/documentation/web-api/reference/artists/get-related-artists/
    }
}

class TopViewModel: ObservableObject {
    let networkAdapter: NetworkAdapter = .init()
    let authPort: AuthenticationPort = AuthenticationAdapter()
    @Published var items: [Artist] = .init()
    private var subscriptions = Set<AnyCancellable>()

    init() {
        networkAdapter.myTopArtists(token: authPort.token)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { print($0) }, //TODO: handle 401
                  receiveValue: { self.items = $0; print($0) })
            .store(in: &subscriptions)
    }
}

struct TopView_Previews: PreviewProvider {
    static var previews: some View {
        TopView()
    }
}
