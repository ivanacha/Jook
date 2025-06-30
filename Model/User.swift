//
//  User.swift
//  Jook
//
//  Created by iVan on 4/29/24.
//

import Foundation

struct User: Identifiable, Codable, Hashable {
    let id: String
    let displayName: String
    let email: String
    let username: String
    var profileImageURL: String?
    var bio: String?
    var profileLink: String?
    var spotifyID: String?
    var spotifyDisplayName: String?
    var currentlyPlaying: String?
    var followers: [String] = []
    var following: [String] = []
    
    var followerCount: Int {
        return followers.count
    }
    
    var followingCount: Int {
        return following.count
    }
}