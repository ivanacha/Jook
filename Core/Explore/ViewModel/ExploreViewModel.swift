//
//  ExploreViewModel.swift
//  Jook
//
//  Created by iVan on 4/29/24.
//

import Foundation

class ExploreViewModel: ObservableObject {
    @Published var users = [User]()
    
    init() {
        Task { try await fetchUsers() }
    }
    
    
    // Call the service function to populate the property used in the View.
    @MainActor
    private func fetchUsers() async throws {
        self.users = try await UserService.fetchUsers()
    }
}
