//
//  ActivityViewModel.swift
//  Jook
//
//  Created by iVan on 5/27/24.
//

import Foundation
import Firebase

@MainActor
class ActivityViewModel: ObservableObject {
    @Published var activities = [Activity]()
    
    init() {
        Task { try await fetchActivities() }
    }
    
    func fetchActivities() async throws {
        guard let currentUserID = Auth.auth().currentUser?.uid else { return }
        self.activities = try await ActivityService.fetchUserActivities(userID: currentUserID)
    }
}