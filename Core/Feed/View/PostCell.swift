//
//  PostView.swift
//  Jook
//
//  Created by iVan on 4/16/24.
//

import SwiftUI

struct PostCell: View {
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 12) {
                ProfileImageView()
                VStack(alignment: .leading) {
                    HStack {
                        Text("username")
                            .font(.footnote)
                            .fontWeight(.semibold)
                        
                        Spacer()
                        
                        Text("10m")
                            .font(.caption)
                            .foregroundStyle(Color(.secondaryLabel))
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "ellipsis")
                                .foregroundStyle(Color(.darkGray))
                        }
                    }
                    
                    Text("Sample review")
                        .font(.footnote)
                        .multilineTextAlignment(.leading)
                    
                    HStack(spacing: 16) {
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
                    .padding(.vertical, 8)
                }
            }
            Divider()
        }
        .padding()

    }
}

#Preview {
    PostCell()
}
