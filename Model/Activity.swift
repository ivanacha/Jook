//
//  Activity.swift
//  Jook
//
//  Created by iVan on 5/27/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

enum ActivityType: String, Codable {
    case like = "like"
    case follow = "follow"
    case post = "post"
    case comment = "comment"
}

struct Activity: Identifiable, Codable {
    @DocumentID var activityID: String?
    let type: ActivityType
    let userID: String
    let targetUserID: String?
    let postID: String?
    let timestamp: Timestamp
    var message: String
    
    var id: String {
        return activityID ?? NSUUID().uuidString
    }
    
    var user: User?
    var targetUser: User?
    var post: Post?
}