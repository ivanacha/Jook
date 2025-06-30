//
//  ProfileViewModel.swift
//  Jook
//
//  Created by iVan on 5/27/24.
//

import Foundation
import Firebase

@MainActor
class ProfileViewModel: ObservableObject {
    @Published var user: User
    @Published var isFollowed = false
    
    init(user: User) {
        self.user = user
        Task {
            await checkIfUserIsFollowed()
            await fetchUpdatedUserData()
        }
    }
    
    func followUser() async throws {
        guard let currentUserID = Auth.auth().currentUser?.uid else { return }
        try await FollowService.followUser(currentUserID: currentUserID, targetUserID: user.id)
        self.isFollowed = true
        
        // Update local follower count
        self.user.followers.append(currentUserID)
    }
    
    func unfollowUser() async throws {
        guard let currentUserID = Auth.auth().currentUser?.uid else { return }
        try await FollowService.unfollowUser(currentUserID: currentUserID, targetUserID: user.id)
        self.isFollowed = false
        
        // Update local follower count
        self.user.followers.removeAll { $0 == currentUserID }
    }
    
    private func checkIfUserIsFollowed() async {
        guard let currentUserID = Auth.auth().currentUser?.uid else { return }
        do {
            self.isFollowed = try await FollowService.checkIfUserIsFollowed(
                currentUserID: currentUserID,
                targetUserID: user.id
            )
        } catch {
            print("Error checking follow status: \(error)")
        }
    }
    
    private func fetchUpdatedUserData() async {
        do {
            self.user = try await UserService.fetchUser(withUID: user.id)
        } catch {
            print("Error fetching updated user data: \(error)")
        }
    }
}