//
//  ActivityService.swift
//  Jook
//
//  Created by iVan on 5/27/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct ActivityService {
    
    static func createActivity(type: ActivityType, userID: String, targetUserID: String? = nil, postID: String? = nil, message: String) async throws {
        let activity = Activity(
            type: type,
            userID: userID,
            targetUserID: targetUserID,
            postID: postID,
            timestamp: Timestamp(),
            message: message
        )
        
        guard let activityData = try? Firestore.Encoder().encode(activity) else { return }
        try await Firestore.firestore().collection("activities").addDocument(data: activityData)
    }
    
    static func fetchUserActivities(userID: String) async throws -> [Activity] {
        // Get user's following list first
        let user = try await UserService.fetchUser(withUID: userID)
        let followingIDs = user.following
        
        // If user isn't following anyone, return empty array
        guard !followingIDs.isEmpty else { return [] }
        
        // Fetch activities from users they're following
        let snapshot = try await Firestore
            .firestore()
            .collection("activities")
            .whereField("userID", in: followingIDs)
            .order(by: "timestamp", descending: true)
            .limit(to: 50)
            .getDocuments()
        
        var activities = snapshot.documents.compactMap({ try? $0.data(as: Activity.self) })
        
        // Fetch user data for each activity
        for i in 0..<activities.count {
            let activity = activities[i]
            
            // Fetch the user who performed the activity
            do {
                activities[i].user = try await UserService.fetchUser(withUID: activity.userID)
            } catch {
                print("Error fetching user for activity: \(error)")
                continue
            }
            
            // Fetch target user if exists
            if let targetUserID = activity.targetUserID {
                do {
                    activities[i].targetUser = try await UserService.fetchUser(withUID: targetUserID)
                } catch {
                    print("Error fetching target user for activity: \(error)")
                }
            }
            
            // Fetch post if exists
            if let postID = activity.postID {
                do {
                    activities[i].post = try await PostService.fetchPost(postID: postID)
                } catch {
                    print("Error fetching post for activity: \(error)")
                }
            }
        }
        
        return activities
    }
}