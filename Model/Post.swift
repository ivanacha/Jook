//
//  Post.swift
//  Jook
//
//  Created by iVan on 5/23/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift


struct Post: Codable, Identifiable {
    @DocumentID var postID: String?
    let ownerUID: String
    let caption: String
    let timestamp: Timestamp
    var likes: Int
    var id: String {
        return postID ?? NSUUID().uuidString
    }
    
    var user: User?
}
