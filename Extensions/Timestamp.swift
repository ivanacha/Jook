//
//  Timestamp.swift
//  Jook
//
//  Created by iVan on 5/27/24.
//

import Foundation
import Firebase

extension Timestamp {
    func toString() -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: self.dateValue(), to: Date()) ?? ""
    }
}
