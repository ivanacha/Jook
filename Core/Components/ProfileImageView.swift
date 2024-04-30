//
//  ProfileImageView.swift
//  Jook
//
//  Created by iVan on 4/16/24.
//

import SwiftUI

struct ProfileImageView: View {
    var user: User?
    var body: some View {
        if let imageURL = user?.profileImageURL {
//            ImageView(withURL: URL(string: imageURL))
        
        } else {
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .frame(width: 50, height: 50)
        }
    }
}

#Preview {
    ProfileImageView()
}
