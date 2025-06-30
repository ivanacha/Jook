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
                    if viewModel.activities.isEmpty && !viewModel.isLoading {
                        VStack(spacing: 16) {
                            Image(systemName: "heart.slash")
                                .font(.system(size: 50))
                                .foregroundStyle(.secondary)
                            
                            Text("No Recent Activity")
                                .font(.title2)
                                .fontWeight(.semibold)
                            
                            Text("Follow some users to see their activity here")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.center)
                        }
                        .padding(.top, 100)
                    } else {
                        ForEach(viewModel.activities) { activity in
                            ActivityCell(activity: activity)
                        }
                    }
                }
                .padding(.horizontal)
            }
            .refreshable {
                Task { try await viewModel.fetchActivities() }
            }
            .navigationTitle("Activity")
            .navigationBarTitleDisplayMode(.inline)
            .overlay {
                if viewModel.isLoading {
                    ProgressView()
                        .scaleEffect(1.2)
                }
            }
        }
    }
}

#Preview {
    ActivityView()
}