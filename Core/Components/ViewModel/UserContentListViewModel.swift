//
//  UserContentListViewModel.swift
//  Jook
//
//  Created by iVan on 5/27/24.
//

import Foundation

class UserContentListViewModel: ObservableObject {
    @Published var posts = [Post]()
    let user: User
    
    init(user: User) {
        self.user = user
        Task { try await fetchPosts() }
    }
    
    @MainActor
    func fetchPosts() async throws {
        var posts = try await PostService.fetchUserPosts(uid: user.id)
        
        for i in 0..<posts.count {
            posts[i].user = self.user
        }
        
        self.posts = posts
    }
}
