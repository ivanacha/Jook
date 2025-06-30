//
//  SpotifyAuthView.swift
//  Jook
//
//  Created by iVan on 5/27/24.
//

import SwiftUI

struct SpotifyAuthView: View {
    @StateObject var spotifyService = SpotifyService.shared
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                Spacer()
                
                Image(systemName: "music.note.list")
                    .font(.system(size: 80))
                    .foregroundColor(.green)
                
                VStack(spacing: 16) {
                    Text("Connect to Spotify")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("Link your Spotify account to share what you're listening to and discover music with friends.")
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.secondary)
                        .padding(.horizontal)
                }
                
                Button {
                    spotifyService.authenticateWithSpotify()
                } label: {
                    HStack {
                        Image(systemName: "music.note")
                        Text("Connect Spotify")
                    }
                    .modifier(ButtonModifier())
                    .background(.green)
                }
                
                Button("Skip for now") {
                    dismiss()
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)
                
                Spacer()
            }
            .padding()
            .navigationTitle("Music Integration")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
        .onChange(of: spotifyService.isAuthenticated) { isAuthenticated in
            if isAuthenticated {
                Task {
                    guard let currentUserID = Auth.auth().currentUser?.uid else { return }
                    try await spotifyService.linkSpotifyAccount(userID: currentUserID)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    SpotifyAuthView()
}