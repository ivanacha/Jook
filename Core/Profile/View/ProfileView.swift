//
//  ProfileView.swift
//  Jook
//
//  Created by iVan on 4/16/24.
//

import SwiftUI

struct ProfileView: View {
    @State private var selectedFilter: ProfileThreadFilter = .posts // Keeps track of the selected filter
    @Namespace var animation
    private var filterBarWidth : CGFloat {
        let count = CGFloat(ProfileThreadFilter.allCases.count)
        return UIScreen.main.bounds.width / count - 15 // UIScreen.main to be deprecated
    }
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    HStack(alignment: .top) {
                        // Bio and stats
                        VStack(alignment: .leading, spacing: 12) {
                            // full name and username
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Full Name")
                                    .fontWeight(.semibold)
                                Text("username")
                            }
                            
                            Text("This is a placeholder for a user bio")
                                .font(.footnote)
                            
                            Text("2 Followers")
                                .font(.caption)
                                .foregroundStyle(.gray)
                        }
                        
                        Spacer()
                        
                        // Profile Image View specific to the profile page
                        Image("Alima-profile")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                    }
                    
                    Button {
                        
                    } label: {
                        Text("Follow")
                            .font (.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor (.white)
                            .frame (width: 352, height: 32)
                            .background(.black)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    
                    // User Content List View
                    VStack {
                        HStack {
                            ForEach(ProfileThreadFilter.allCases) {filter in
                                VStack {
                                    Text(filter.title)
                                        .font(.subheadline)
                                        .fontWeight(selectedFilter == filter ? .semibold : .regular)
                                    
                                    if selectedFilter == filter {
                                        Rectangle()
                                            .foregroundStyle(.black)
                                            .frame(width: filterBarWidth, height: 1)
                                            .matchedGeometryEffect(id: "item", in: animation)
                                    } else {
                                        Rectangle()
                                            .foregroundStyle(.clear)
                                            .frame(width: filterBarWidth, height: 1)
                                    }
                                }
                                .onTapGesture {
                                    withAnimation(.spring) {
                                        selectedFilter = filter
                                    }
                                }
                            }
                        }
                        
                        LazyVStack {
                            ForEach(0...10, id:\.self) { post in
                                PostCell()
                            }
                        }
                    }
                    .padding(.vertical, 8)
                }
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

#Preview {
    ProfileView()
}
