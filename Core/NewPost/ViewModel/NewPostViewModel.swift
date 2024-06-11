//
//  NewPostViewModel.swift
//  Jook
//
//  Created by iVan on 5/23/24.
//

import Firebase

class NewPostViewModel: ObservableObject {
    
    func uploadPost(caption: String) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let post = Post(ownerUID: uid, caption: caption, timestamp: Timestamp(), likes: 0)
        try await PostService.uploadPost(post)
    }
}
