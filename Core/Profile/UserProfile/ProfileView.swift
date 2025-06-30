//
//  ProfileView.swift
//  Jook
//
//  Created by iVan on 4/16/24.
//

import SwiftUI
import Firebase

struct ProfileView: View {
    let user: User
    @StateObject var viewModel: ProfileViewModel
    
    init(user: User) {
        self.user = user
        self._viewModel = StateObject(wrappedValue: ProfileViewModel(user: user))
    }
    
    private var filterBarWidth : CGFloat {
        let count = CGFloat(ProfileThreadFilter.allCases.count)
        return UIScreen.main.bounds.width / count - 15 // UIScreen.main to be deprecated
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ProfileHeaderView(user: viewModel.user)
                
                Button {
                    Task {
                        if viewModel.isFollowed {
                            try await viewModel.unfollowUser()
                        } else {
                            try await viewModel.followUser()
                        }
                    }
                } label: {
                    Text(viewModel.isFollowed ? "Following" : "Follow")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(viewModel.isFollowed ? .black : .white)
                        .frame(width: 352, height: 32)
                        .background(viewModel.isFollowed ? .white : .black)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .overlay {
                            if viewModel.isFollowed {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color(.systemGray4), lineWidth: 1)
                            }
                        }
                }
                
                // User Content List View
                UserContentListView(user: viewModel.user)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .scrollIndicators(.never)
        .padding(.horizontal)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: dev.user)
    }
}