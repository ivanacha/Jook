//
//  ActivityCell.swift
//  Jook
//
//  Created by iVan on 5/27/24.
//

import SwiftUI

struct ActivityCell: View {
    let activity: Activity
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            NavigationLink(destination: ProfileView(user: activity.user ?? User(id: "", displayName: "", email: "", username: ""))) {
                ProfileImageView(user: activity.user, size: .small)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    NavigationLink(destination: ProfileView(user: activity.user ?? User(id: "", displayName: "", email: "", username: ""))) {
                        Text(activity.user?.username ?? "")
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                    }
                    
                    Text(activity.message)
                    
                    if let targetUser = activity.targetUser {
                        NavigationLink(destination: ProfileView(user: targetUser)) {
                            Text(targetUser.username)
                                .fontWeight(.semibold)
                                .foregroundColor(.primary)
                        }
                    }
                    
                    Spacer()
                    
                    Text(activity.timestamp.toString())
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .font(.footnote)
                
                if activity.type == .post, let post = activity.post {
                    Text(post.caption)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .lineLimit(2)
                        .padding(.top, 2)
                }
            }
            
            if activity.type == .follow {
                Button("Follow") {
                    // Handle follow action
                }
                .font(.caption)
                .fontWeight(.semibold)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(Color.black)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 6))
            }
        }
        .padding(.vertical, 8)
    }
}