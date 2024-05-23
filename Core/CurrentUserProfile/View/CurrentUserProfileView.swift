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
                    
                    Button {
                        showEditProfile.toggle()
                    } label: {
                        Text("Edit Profile")
                            .font (.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor (.black)
                            .frame (width: 352, height: 32)
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color(.systemGray4), lineWidth: 1)
                            }
                    }
                    
                    // User Content List View
                    UserContentListView()
                }
            }
            .sheet(isPresented: $showEditProfile) {
                EditProfileView(user: currentUser)
                    .environmentObject(viewModel)
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
