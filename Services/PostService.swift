//
//  PostService.swift
//  Jook
//
//  Created by iVan on 5/23/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct PostService {
        
    static func uploadPost(_ post: Post) async throws {
        guard let postData = try? Firestore.Encoder().encode(post) else { return }
        let docRef = try await Firestore.firestore().collection("posts").addDocument(data: postData)
        
        // Create activity for new post
        try await ActivityService.createActivity(
            type: .post,
            userID: post.ownerUID,
            postID: docRef.documentID,
            message: "created a new post"
        )
    }
    
    static func fetchPosts() async throws -> [Post] {
        let snapshot = try await Firestore
            .firestore()
            .collection("posts")
            .order(by: "timestamp", descending: true)
            .getDocuments()
        
        return snapshot.documents.compactMap({ try? $0.data(as: Post.self) })
    }
    
    static func fetchUserPosts(uid: String) async throws -> [Post] {
        let snapshot = try await Firestore
            .firestore()
            .collection("posts")
            .whereField("ownerUID", isEqualTo: uid)
            .getDocuments()
        
        let posts = snapshot.documents.compactMap({ try? $0.data(as: Post.self) })
        return posts.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() })
    }
    
    static func fetchPost(postID: String) async throws -> Post {
        let snapshot = try await Firestore.firestore().collection("posts").document(postID).getDocument()
        return try snapshot.data(as: Post.self)
    }
}