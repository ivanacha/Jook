//
//  PreviewProvider.swift
//  Jook
//
//  Created by iVan on 4/29/24.
//

import SwiftUI

extension PreviewProvider {
    static var dev: DevPreview {
        return DevPreview.shared
    }
}

class DevPreview {
    static let shared = DevPreview()
    
    let user = User(id: NSUUID().uuidString, displayName: "Preview Name", email: "preview@mail.com", username: "mock_user")
}
