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
    }
}

struct ProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderView(user: dev.user)
    }
}
