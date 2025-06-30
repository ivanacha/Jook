//
//  PreviewProvider.swift
//  Jook
//
//  Created by iVan on 4/29/24.
//

import SwiftUI
import Firebase

extension PreviewProvider {
    static var dev: DevPreview {
        return DevPreview.shared
    }
}

class DevPreview {
    static let shared = DevPreview()
    
    let user = User(id: NSUUID().uuidString, displayName: "Preview Name", email: "preview@mail.com", username: "mock_user")
    
    let post = Post(ownerUID: "123", caption: "This is a test post", timestamp: Timestamp(), likes: 0)
}
