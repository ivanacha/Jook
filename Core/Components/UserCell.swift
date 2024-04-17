//
//  UserCell.swift
//  Jook
//
//  Created by iVan on 4/16/24.
//

import SwiftUI

struct UserCell: View {
    var body: some View {
        HStack {
            ProfileImageView()
            
            VStack(alignment: .leading) {
                Text("username")
                    .fontWeight(.semibold)
            }
            .font(.footnote)
            
            Spacer()
           
           Text("Follow")
               .font(.subheadline)
               .fontWeight(.semibold)
               .frame(width: 100, height: 32)
               .overlay {
                   RoundedRectangle(cornerRadius: 10)
                       .stroke(Color(.systemGray4), lineWidth: 1)
               }

        }
        .padding(.horizontal)
    }
}

#Preview {
    UserCell()
}
