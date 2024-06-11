//
//  FeedViewModel.swift
//  Jook
//
//  Created by iVan on 5/23/24.
//

import Foundation

@MainActor
class FeedViewModel: ObservableObject {
    @Published var posts = [Post]()
    
    init() {
        Task { try await fetchPosts() }
    }
    
    func fetchPosts() async throws {
        self.posts = try await PostService.fetchPosts()
        try await fetchUserData()
    }
    
    private func fetchUserData() async throws {
        for i in 0..<posts.count {
            let post = posts[i]
            let ownerUID = post.ownerUID
            
            let postUser = try await UserService.fetchUser(withUID: ownerUID)
            
            posts[i].user = postUser
        }
    }
}
