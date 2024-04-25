//
//  RegistrationViewModel.swift
//  Jook
//
//  Created by iVan on 4/22/24.
//

import Foundation

class RegistrationViewModel: ObservableObject {
    @Published var password = ""
    @Published var email = ""
    @Published var username = ""
    @Published var displayName = ""
    
    @MainActor
    func createUser() async throws {
        try await AuthService.shared.createUser(
            withEmail: email,
            password: password,
            displayName: displayName,
            username: username
        )
    }
}
