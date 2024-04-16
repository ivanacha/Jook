//
//  TextfieldModifier.swift
//  Jook
//
//  Created by iVan on 4/16/24.
//

import SwiftUI
struct CustomTextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .padding(12)
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.horizontal, 20)
    }
}
