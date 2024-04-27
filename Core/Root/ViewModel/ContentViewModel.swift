//
//  ContentViewModel.swift
//  Jook
//
//  Created by iVan on 4/22/24.
//

import Foundation
import Combine  // used to listen or when the userSession receives a value
import Firebase

class ContentViewModel: ObservableObject {
    
    // Used to keep track of user session.
    @Published var userSession: FirebaseAuth.User?
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupSubscribers()
    }
    
    private func setupSubscribers() {
        AuthService.shared.$userSession.sink { [weak self] userSession in
            self?.userSession = userSession
        }.store(in: &cancellables)
    }
}
