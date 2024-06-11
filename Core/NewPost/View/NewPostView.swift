//
//  NewPostView.swift
//  Jook
//
//  Created by iVan on 4/16/24.
//

import SwiftUI

struct NewPostView: View {
    @Environment(\.dismiss) var dismiss
    @State private var caption = ""
    @StateObject var viewModel = NewPostViewModel()
    
    // If fetching the user fails, we may have add the Combine functionality of listening for the user.
    private var currentUser: User? {
        return UserService.shared.currentUser
    }
    
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack(alignment: .top) {
                    ProfileImageView(user: currentUser,size: .small)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(currentUser?.username ?? "")
                            .fontWeight(.semibold)
                        TextField("What are you listening to?", text: $caption, axis: .vertical)
                    }
                    
                    Spacer()
                    
                    if !caption.isEmpty {
                        Button {
                            caption = ""
                        } label: {
                            Image(systemName: "xmark")
                                .resizable()
                                .frame(width: 12, height: 12)
                                .foregroundStyle(.black)
                        }
                    }
                }
                Spacer()
            }
            .padding()
            .navigationTitle("New Post")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .font(.subheadline)
                    .foregroundStyle(.black)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Post") {
                        Task {
                            try await viewModel.uploadPost(caption: caption)
                            dismiss()
                        }
                    }
                    .opacity(caption.isEmpty ? 0.5 : 1.0)
                    .disabled(caption.isEmpty)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                }
            }
        }
        
    }
}

struct NewPostViewPreviews: PreviewProvider {
    static var previews: some View{
        NewPostView()
    }
}
