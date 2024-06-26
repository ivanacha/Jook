//
//  ProfileView.swift
//  Jook
//
//  Created by iVan on 4/16/24.
//

import SwiftUI

struct ProfileView: View {
    let user: User
    
    private var filterBarWidth : CGFloat {
        let count = CGFloat(ProfileThreadFilter.allCases.count)
        return UIScreen.main.bounds.width / count - 15 // UIScreen.main to be deprecated
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ProfileHeaderView(user: user)
                
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
                UserContentListView()
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
