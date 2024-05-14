//
//  ContentView.swift
//  Jook
//
//  Created by iVan on 4/16/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                // If the user is signed in show TabView
                HomeTabView(user: nil)
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    ContentView()
}
