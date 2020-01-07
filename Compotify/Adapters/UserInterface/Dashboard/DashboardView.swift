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
            DemoView()
                .font(.title)
                .tabItem {
                    VStack {
                        Image("first")
                        Text("First")
                    }
                }
                .tag(0)
            ProfileView()
                .font(.title)
                .tabItem {
                    VStack {
                        Image("second")
                        Text("Profile")
                    }
                }
                .tag(1)
        }
    }
}

struct DemoView: View {
    var body: some View {
        Text("First View")
    }
}

struct ProfileView: View {
    //TODO: remove from here
    private let authentication = (UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate).authentication

    var body: some View {
        Button(action: {
            self.authentication.logout()
        }, label: { Text("Logout") })
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
