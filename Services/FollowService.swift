//
//  FollowService.swift
//  Jook
//
//  Created by iVan on 5/27/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct FollowService {
    
    static func followUser(currentUserID: String, targetUserID: String) async throws {
        let batch = Firestore.firestore().batch()
        
        // Add to current user's following
        let currentUserRef = Firestore.firestore().collection("users").document(currentUserID)
        batch.updateData(["following": FieldValue.arrayUnion([targetUserID])], forDocument: currentUserRef)
        
        // Add to target user's followers
        let targetUserRef = Firestore.firestore().collection("users").document(targetUserID)
        batch.updateData(["followers": FieldValue.arrayUnion([currentUserID])], forDocument: targetUserRef)
        
        try await batch.commit()
        
        // Create activity
        try await ActivityService.createActivity(
            type: .follow,
            userID: currentUserID,
            targetUserID: targetUserID,
            message: "started following you"
        )
    }
    
    static func unfollowUser(currentUserID: String, targetUserID: String) async throws {
        let batch = Firestore.firestore().batch()
        
        // Remove from current user's following
        let currentUserRef = Firestore.firestore().collection("users").document(currentUserID)
        batch.updateData(["following": FieldValue.arrayRemove([targetUserID])], forDocument: currentUserRef)
        
        // Remove from target user's followers
        let targetUserRef = Firestore.firestore().collection("users").document(targetUserID)
        batch.updateData(["followers": FieldValue.arrayRemove([currentUserID])], forDocument: targetUserRef)
        
        try await batch.commit()
    }
    
    static func checkIfUserIsFollowed(currentUserID: String, targetUserID: String) async throws -> Bool {
        let currentUser = try await UserService.fetchUser(withUID: currentUserID)
        return currentUser.following.contains(targetUserID)
    }
}