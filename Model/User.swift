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
    
}
