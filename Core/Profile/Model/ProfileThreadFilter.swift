//
//  ProfileThreadFilter.swift
//  Jook
//
//  Created by iVan on 4/17/24.
//

import Foundation

enum ProfileThreadFilter: Int, CaseIterable, Identifiable {
    var id: Int { return self.rawValue }  // This is to enable Swift to identify each view
    case posts
    case replies
    case reviews
//    case likes
    var title: String {
        switch self {
        case .posts: return "Posts"
        case .replies: return "Replies"
        case .reviews: return "Reviews"
        }
    }
}
