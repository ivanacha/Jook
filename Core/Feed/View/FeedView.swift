//
//  FeedView.swift
//  Jook
//
//  Created by iVan on 4/16/24.
//

import SwiftUI

struct FeedView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(0...10, id: \.self) { thread in
                        PostCell()
                    }
                }
            }
            .refreshable {
                print("DEBUG: Refresh feed")
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
