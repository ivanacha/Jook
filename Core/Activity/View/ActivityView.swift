//
//  ActivityView.swift
//  Jook
//
//  Created by iVan on 4/16/24.
//

import SwiftUI

struct ActivityView: View {
    @StateObject var viewModel = ActivityViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(viewModel.activities) { activity in
                        ActivityCell(activity: activity)
                    }
                }
                .padding(.horizontal)
            }
            .refreshable {
                Task { try await viewModel.fetchActivities() }
            }
            .navigationTitle("Activity")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ActivityView()
}