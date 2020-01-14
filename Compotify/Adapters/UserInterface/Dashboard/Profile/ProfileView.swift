//
//  ProfileView.swift
//  Compotify
//
//  Created by Alberto Penas Amor on 10/01/2020.
//  Copyright © 2020 com.github.albertopeam. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    //TODO: remove from here
    private let authentication = (UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate).authentication

    var body: some View {
        Button(action: {
            self.authentication.logout()
        }, label: { Text("Logout") })
    }
}
