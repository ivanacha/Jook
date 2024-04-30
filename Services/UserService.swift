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
    
}
