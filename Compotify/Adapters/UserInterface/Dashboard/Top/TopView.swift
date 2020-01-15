//
//  TopView.swift
//  Compotify
//
//  Created by Alberto Penas Amor on 10/01/2020.
//  Copyright © 2020 com.github.albertopeam. All rights reserved.
//

import SwiftUI
import Combine
import KingfisherSwiftUI

struct TopView: View {

    //TODO: make injections
    @ObservedObject var viewModel: TopViewModel = .init()
    
    var body: some View {
        NavigationView {
            //TODO: horizontal...
            List {
                ForEach(viewModel.items) { item in
                    Text(item.name)
                    KFImage(item.image) // image is not loading
                        .resizable()
                        .frame(width: 128, height: 128)
                        .cornerRadius(20)
                        .shadow(radius: 5)
                }
                /*ScrollView(.horizontal, content: {
                    HStack(spacing: 10) {
                        ForEach(viewModel.items) { item in
                            Text(item.name)
                            KFImage(item.image)
                                .resizable()
                                .frame(width: 128, height: 128)
                                .cornerRadius(20)
                                .shadow(radius: 5)
                        }
                    }
                    .padding(.leading, 10)
                })
                .frame(height: 190)*/
            }
            .padding(.leading, -20)
            .padding(.trailing, -20)
        }.onAppear(perform: { self.viewModel.get() })
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
}

//TODO: move out of here
class TopViewModel: ObservableObject {
    @Published var items: [ArtistDecorator] = .init()
    private let networkAdapter: NetworkAdapter = .init()
    private let authPort: AuthenticationPort = AuthenticationAdapter()
    private var subscriptions = Set<AnyCancellable>()

    init() {
        //TODO: move injections to here
    }

    func get() {
        networkAdapter.myTopArtists(token: authPort.token)
        .map({ $0.map({ ArtistDecorator($0) }) })
        .receive(on: RunLoop.main)
        .sink(receiveCompletion: { print($0) }, //TODO: handle 401
              receiveValue: { self.items = $0 })
        .store(in: &subscriptions)
    }
}

struct TopView_Previews: PreviewProvider {
    static var previews: some View {
        TopView()
    }
}
