//
//  ButtonModifier.swift
//  Jook
//
//  Created by iVan on 4/16/24.
//

import SwiftUI

struct ButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(.white)
            .fontWeight(.semibold)
            .frame(width: 350, height: 40)
            .background(.black)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
