//
//  ProfileImageView.swift
//  Jook
//
//  Created by iVan on 4/16/24.
//

import SwiftUI

struct ProfileImageView: View {
    var body: some View {
        Image("Alima-profile")
            .resizable()
            .scaledToFill()
            .frame(width: 50, height: 50)
            .clipShape(Circle())
    }
}

#Preview {
    ProfileImageView()
}
