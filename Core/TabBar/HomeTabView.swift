//
//  PostsTabView.swift
//  Jook
//
//  Created by iVan on 4/16/24.
//

import SwiftUI
struct HomeTabView: View {
    @State private var selectedTab = 0
    @State private var showNewPostView = false
    @State private var recentlySelectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            FeedView()
                .tabItem {
                    Image(systemName: selectedTab == 0 ? "house.fill" : "house")
                        .environment(\.symbolVariants, selectedTab == 0 ? .fill : .none)
                }
                .onAppear { selectedTab = 0 }
                .tag(0)
            
            ExploreView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
                .onAppear { selectedTab = 1 }
                .tag(1)
            
            Text("")
                .tabItem {
                    Image(systemName: "plus")
                }
                .onAppear { selectedTab = 2 }
                .tag(2)
            
            ActivityView()
                .tabItem {
                    Image(systemName: selectedTab == 3 ? "heart.fill" : "heart")
                        .environment(\.symbolVariants, selectedTab == 3 ? .fill : .none)
                }
                .onAppear { selectedTab = 3 }
                .tag(3)
            
            CurrentUserProfileView()
                .tabItem {
                    Image(systemName: selectedTab == 4 ? "person.fill" : "person")
                        .environment(\.symbolVariants, selectedTab == 4 ? .fill : .none)
                }
                .onAppear { selectedTab = 4 }
                .tag(4)

        }
        .onChange(of: selectedTab) { newValue, _ in
            recentlySelectedTab = newValue
            if selectedTab == 2 {
                showNewPostView = true
            }
        }
        .sheet(isPresented: $showNewPostView, onDismiss: {
            selectedTab = recentlySelectedTab
        }, content: {
            NewPostView()
        })
        .tint(.black)
    }
}

struct HomeTabViewPreviews: PreviewProvider {
    static var previews: some View {
        HomeTabView()
    }
}
