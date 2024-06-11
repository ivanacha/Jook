//
//  FeedView.swift
//  Jook
//
//  Created by iVan on 4/16/24.
//

import SwiftUI

struct FeedView: View {
    @StateObject var viewModel = FeedViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.posts) { post in
                        PostCell(post: post)
                    }
                }
            }
            .refreshable {
                Task { try await viewModel.fetchPosts() }
            }
            .scrollIndicators(.hidden)
            .navigationTitle("Jook")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    FeedView()
}
