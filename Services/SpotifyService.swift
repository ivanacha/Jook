//
//  SpotifyService.swift
//  Jook
//
//  Created by iVan on 5/27/24.
//

import Foundation
import AuthenticationServices
import Firebase

class SpotifyService: NSObject, ObservableObject {
    static let shared = SpotifyService()
    
    private let clientID = "YOUR_SPOTIFY_CLIENT_ID" // Replace with your Spotify Client ID
    private let redirectURI = "jook://spotify-callback"
    private let scopes = "user-read-currently-playing user-read-playback-state user-library-read"
    
    @Published var isAuthenticated = false
    @Published var accessToken: String?
    @Published var currentlyPlaying: SpotifyTrack?
    
    private override init() {
        super.init()
    }
    
    func authenticateWithSpotify() {
        let authURL = buildAuthURL()
        
        guard let url = URL(string: authURL) else { return }
        
        let session = ASWebAuthenticationSession(url: url, callbackURLScheme: "jook") { [weak self] callbackURL, error in
            if let error = error {
                print("Spotify auth error: \(error.localizedDescription)")
                return
            }
            
            guard let callbackURL = callbackURL else { return }
            self?.handleCallback(url: callbackURL)
        }
        
        session.presentationContextProvider = self
        session.start()
    }
    
    private func buildAuthURL() -> String {
        let baseURL = "https://accounts.spotify.com/authorize"
        let params = [
            "client_id": clientID,
            "response_type": "code",
            "redirect_uri": redirectURI,
            "scope": scopes,
            "show_dialog": "true"
        ]
        
        let queryString = params.map { "\($0.key)=\($0.value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")" }
            .joined(separator: "&")
        
        return "\(baseURL)?\(queryString)"
    }
    
    private func handleCallback(url: URL) {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
              let queryItems = components.queryItems,
              let code = queryItems.first(where: { $0.name == "code" })?.value else {
            return
        }
        
        Task {
            await exchangeCodeForToken(code: code)
        }
    }
    
    private func exchangeCodeForToken(code: String) async {
        // Implementation for token exchange
        // This would typically involve making a POST request to Spotify's token endpoint
        // For now, we'll simulate success and create/update user
        DispatchQueue.main.async {
            self.isAuthenticated = true
            self.accessToken = "mock_access_token"
        }
        
        // Create or update user in Firebase if they don't exist
        await createOrUpdateSpotifyUser()
    }
    
    private func createOrUpdateSpotifyUser() async {
        guard let currentUser = Auth.auth().currentUser else {
            // If no Firebase user exists, create one for the Spotify user
            await createFirebaseUserForSpotify()
            return
        }
        
        // Update existing Firebase user with Spotify info
        do {
            try await UserService.shared.updateUserSpotifyInfo(
                spotifyID: "mock_spotify_id",
                spotifyDisplayName: "Spotify User"
            )
        } catch {
            print("Error updating Spotify info: \(error)")
        }
    }
    
    private func createFirebaseUserForSpotify() async {
        // This would typically involve creating a Firebase user account
        // using Spotify user information. For now, we'll just mark as authenticated
        print("Would create Firebase user for Spotify user")
    }
    
    func getCurrentlyPlaying() async -> SpotifyTrack? {
        guard let accessToken = accessToken else { return nil }
        
        // Implementation for fetching currently playing track
        // This would make a request to Spotify's currently playing endpoint
        // For now, we'll return a mock track
        return SpotifyTrack(
            name: "Sample Song",
            artist: "Sample Artist",
            album: "Sample Album",
            imageURL: nil
        )
    }
    
    func linkSpotifyAccount(userID: String) async throws {
        guard isAuthenticated else { return }
        
        // Update user with Spotify information
        try await UserService.shared.updateUserSpotifyInfo(
            spotifyID: "mock_spotify_id",
            spotifyDisplayName: "Spotify User"
        )
    }
    
    func updateCurrentlyPlaying() async {
        guard let track = await getCurrentlyPlaying() else {
            // Clear currently playing if no track
            try? await UserService.shared.updateCurrentlyPlaying(track: nil)
            return
        }
        
        let trackString = "\(track.name) by \(track.artist)"
        try? await UserService.shared.updateCurrentlyPlaying(track: trackString)
    }
}

extension SpotifyService: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return ASPresentationAnchor()
    }
}

struct SpotifyTrack: Codable {
    let name: String
    let artist: String
    let album: String
    let imageURL: String?
}