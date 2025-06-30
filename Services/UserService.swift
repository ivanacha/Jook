//
//  UserService.swift
//  Jook
//
//  Created by iVan on 4/29/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class UserService {
    @Published var currentUser: User?
    
    static let shared = UserService()
    
    init() {
        Task { try await fetchCurrentUser() }
    }
    
    @MainActor
    func fetchCurrentUser() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return } // Make sure that a user is currently logged in.
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        let user = try snapshot.data(as: User.self)
        self.currentUser = user
    }
    
    static func fetchUsers() async throws -> [User] {
        guard let currentUid = Auth.auth().currentUser?.uid else { return [] } // Capture the current user ID.
        let snapshot = try await Firestore.firestore().collection("users").getDocuments()
        let users  = snapshot.documents.compactMap({ try? $0.data(as: User.self)}) // Take all documents from users collection onto a user.
        
        return users.filter({ $0.id != currentUid }) // Filter current user ID from the user list.
    }
    
    static func fetchUser(withUID uid: String) async throws -> User {
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        return try snapshot.data(as: User.self)
    }
    
    // Reset the current user locally.
    func reset() {
        self.currentUser = nil
    }
    
    @MainActor
    func updateUserProfileImage(withImageURL imageURL: String) async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return } // Capture the current user ID.
        try await Firestore.firestore().collection("users").document(currentUid).updateData([
            "profileImageURL": imageURL //Updates user profile image on the Firebase database.
        ])
        self.currentUser?.profileImageURL = imageURL // Updates the current user's profile image locally through combine listeners.
    }
    
    @MainActor
    func updateUserSpotifyInfo(spotifyID: String, spotifyDisplayName: String) async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        try await Firestore.firestore().collection("users").document(currentUid).updateData([
            "spotifyID": spotifyID,
            "spotifyDisplayName": spotifyDisplayName
        ])
        self.currentUser?.spotifyID = spotifyID
        self.currentUser?.spotifyDisplayName = spotifyDisplayName
    }
    
    @MainActor
    func updateCurrentlyPlaying(track: String?) async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let data: [String: Any] = track != nil ? ["currentlyPlaying": track!] : ["currentlyPlaying": FieldValue.delete()]
        
        try await Firestore.firestore().collection("users").document(currentUid).updateData(data)
        self.currentUser?.currentlyPlaying = track
    }
}