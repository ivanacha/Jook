//
//  LoginViewModel.swift
//  Jook
//
//  Created by iVan on 4/22/24.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var password = ""
    @Published var email = ""

    
    @MainActor
    func login() async throws {
        try await AuthService.shared.login(withEmail: email, password: password)
    }
}
