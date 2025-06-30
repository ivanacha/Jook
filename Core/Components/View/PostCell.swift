//
//  PostView.swift
//  Jook
//
//  Created by iVan on 4/16/24.
//

import SwiftUI

struct PostCell: View {
    let post: Post
    
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 10) {
                NavigationLink(destination: ProfileView(user: post.user ?? User(id: "", displayName: "", email: "", username: ""))) {
                    ProfileImageView(user: post.user, size: .small)
                }
                
                VStack(alignment: .leading) {
                    HStack {
                        NavigationLink(destination: ProfileView(user: post.user ?? User(id: "", displayName: "", email: "", username: ""))) {
                            Text(post.user?.username ?? "")
                                .font(.footnote)
                                .fontWeight(.semibold)
                                .foregroundColor(.primary)
                        }
                        
                        Spacer()
                        
                        Text(post.timestamp.toString())
                            .font(.caption)
                            .foregroundStyle(Color(.secondaryLabel))
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "ellipsis")
                                .foregroundStyle(Color(.darkGray))
                        }
                    }
                    
                    Text(post.caption)
                        .font(.footnote)
                        .multilineTextAlignment(.leading)
                    
                    // Include the counters between the icons
                    HStack(spacing: 70) {
                        Button {
                            
                        } label: {
                            Image(systemName: "heart")
                        }
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "text.bubble")
                        }
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "arrow.circlepath")
                        }
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "paperplane.circle")
                        }
                    }
                    .foregroundStyle(Color(.black))
                    .padding(.vertical, 5)
                }
            }
            Divider()
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 3)
    }
}

struct PostCellPreviews: PreviewProvider {
    static var previews: some View{
        PostCell(post: dev.post)
    }
}