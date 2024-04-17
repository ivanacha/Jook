//
//  ExploreView.swift
//  Jook
//
//  Created by iVan on 4/16/24.
//

import SwiftUI

struct ExploreView: View {
    @State private var searchText = ""
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(0...10, id:\.self) { user in
                        VStack {
                            UserCell()
                            Divider()
                        }
                        .padding(.vertical, 3)

                    }
                }
            }
            .navigationTitle("Explore")
            .searchable(text: $searchText, prompt: "Search")
        }
    }
}

#Preview {
    ExploreView()
}
