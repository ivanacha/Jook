//
//  ProfileHeaderView.swift
//  Jook
//
//  Created by iVan on 4/29/24.
//

import SwiftUI

struct ProfileHeaderView: View {
    let user: User?
    
    init(user: User?) {
        self.user = user
    }
    
    var body: some View {
        HStack(alignment: .top) {
            // Bio and stats
            VStack(alignment: .leading, spacing: 12) {
                // full name and username
                VStack(alignment: .leading, spacing: 4) {
                    Text(user?.displayName ?? "")
                        .fontWeight(.semibold)
                    Text(user?.username ?? "")
                }
                
                if let bio = user?.bio {
                    Text(bio)
                        .font(.footnote)
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    HStack(spacing: 8) {
                        Text("\(user?.followerCount ?? 0)")
                            .fontWeight(.semibold)
                        Text("Followers")
                        
                        Text("\(user?.followingCount ?? 0)")
                            .fontWeight(.semibold)
                        Text("Following")
                    }
                    .font(.caption)
                    .foregroundStyle(.gray)
                    
                    // Spotify status
                    if let currentlyPlaying = user?.currentlyPlaying {
                        HStack(spacing: 4) {
                            Image(systemName: "music.note")
                                .font(.caption2)
                                .foregroundColor(.green)
                            Text("Listening to \(currentlyPlaying)")
                                .font(.caption2)
                                .foregroundStyle(.secondary)
                                .lineLimit(1)
                        }
                        .padding(.top, 2)
                    } else if let spotifyDisplayName = user?.spotifyDisplayName {
                        HStack(spacing: 4) {
                            Image(systemName: "music.note")
                                .font(.caption2)
                                .foregroundColor(.green)
                            Text("Connected to Spotify")
                                .font(.caption2)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.top, 2)
                    }
                }
            }
            
            Spacer()
            
            // Profile Image View specific to the profile page
            ProfileImageView(user: user, size: .xLarge)
        }
    }
}

struct ProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderView(user: dev.user)
    }
}