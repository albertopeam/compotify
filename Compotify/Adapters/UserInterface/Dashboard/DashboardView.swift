//
//  ContentView.swift
//  Compotify
//
//  Created by Alberto Penas Amor on 22/12/2019.
//  Copyright © 2019 com.github.albertopeam. All rights reserved.
//

import SwiftUI

struct DashboardView: View {
    @State private var selection = 0
 
    var body: some View {
        TabView(selection: $selection){
            TopView()
                .font(.title)
                .tabItem {
                    VStack {
                        Image("star")
                        Text("My Top")
                    }
                }
                .tag(0)
            ProfileView()
                .font(.title)
                .tabItem {
                    VStack {
                        Image("user")
                        Text("Profile")
                    }
                }
                .tag(1)
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
