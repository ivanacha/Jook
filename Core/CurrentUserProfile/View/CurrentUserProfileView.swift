//
//  CurrentUserVIew.swift
//  Jook
//
//  Created by iVan on 4/29/24.
//

import SwiftUI

struct CurrentUserProfileView: View {
    @StateObject var viewModel = CurrentUserProfileViewModel()
    @State private var showEditProfile = false
    @State private var showSpotifyAuth = false

    private var filterBarWidth : CGFloat {
        let count = CGFloat(ProfileThreadFilter.allCases.count)
        return UIScreen.main.bounds.width / count - 15 // UIScreen.main to be deprecated
    }
    
    private var currentUser: User? {
        return viewModel.currentUser
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Bio and stats
                    ProfileHeaderView(user: currentUser)
                    
                    HStack(spacing: 12) {
                        Button {
                            showEditProfile.toggle()
                        } label: {
                            Text("Edit Profile")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity, height: 32)
                                .background(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color(.systemGray4), lineWidth: 1)
                                }
                        }
                        
                        if currentUser?.spotifyID == nil {
                            Button {
                                showSpotifyAuth.toggle()
                            } label: {
                                HStack(spacing: 4) {
                                    Image(systemName: "music.note")
                                    Text("Spotify")
                                }
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(width: 100, height: 32)
                                .background(.green)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            }
                        }
                    }
                    
                    // User Content List View
                    if let user = currentUser {
                        UserContentListView(user: user)
                    }
                }
            }
            .sheet(isPresented: $showEditProfile) {
                EditProfileView(user: currentUser)
                    .environmentObject(viewModel)
            }
            .sheet(isPresented: $showSpotifyAuth) {
                SpotifyAuthView()
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    // !!!  DO NOT FORGET TO IMPLEMENT SETTINGS PAGE !!!
                    Button {
                        AuthService.shared.signOut() // The settings logo at the top of the page just signs the user out for now.
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .foregroundStyle(Color(.black))
                    }
                }
            }
            .scrollIndicators(.never)
            .padding(.horizontal)
        }
    }
}

struct CurrentUserProfileViewPreviews: PreviewProvider {
    static var previews: some View {
        CurrentUserProfileView()
    }
}