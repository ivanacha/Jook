//
//  ImageUploader.swift
//  Jook
//
//  Created by iVan on 4/29/24.
//

import Firebase
import FirebaseStorage

struct ImageUploader {
    static func uploadImage(_ image: UIImage) async throws -> String? {
        guard let imageData = image.jpegData(compressionQuality: 0.25) else { return nil} // To optmize data loading, compress larger images.
        let filename = NSUUID().uuidString
        let storageRef = Storage.storage().reference(withPath: "/profile_images/\(filename)")
        
        do {
            let _ = try await storageRef.putDataAsync(imageData)
            let url = try await storageRef.downloadURL()
            return url.absoluteString
        } catch {
            print("DEBUG: Failed ro upload image with error: \(error.localizedDescription)")
            return nil
        }
    }
}
