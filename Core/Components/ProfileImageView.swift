//
//  ProfileImageView.swift
//  Jook
//
//  Created by iVan on 4/16/24.
//

import SwiftUI

enum ProfileImageSize {
    case xxSmall
    case xSmall
    case small
    case medium
    case large
    case xLarge
    
    var dimension: CGFloat {
        switch self {
        case .xxSmall: 28
        case .xSmall: 32
        case .small: 40
        case .medium: 48
        case .large: 64
        case .xLarge: 80
        }
    }
}
struct ProfileImageView: View {
    var user: User?
    let size: ProfileImageSize
    
    var body: some View {
        if let imageURL = user?.profileImageURL {
//            ImageView(withURL: URL(string: imageURL))
            AsyncImage(url: URL(string: imageURL)) { image in
                image.resizable()
                    .scaledToFill()
                    .frame(width: size.dimension, height: size.dimension)
                    .clipShape(Circle())
            } placeholder: {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: size.dimension, height: size.dimension)
            }
        } else {
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .frame(width: size.dimension, height: size.dimension)
        }
    }
}

struct ProfileImageView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: dev.user)
    }
}
