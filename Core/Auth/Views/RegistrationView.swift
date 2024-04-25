//
//  RegistrationView.swift
//  Jook
//
//  Created by iVan on 4/16/24.
//

import SwiftUI

struct RegistrationView: View {
    @StateObject var viewModel = RegistrationViewModel()
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            Spacer()
            Image("vinyl-icon")
                .resizable()
                .scaledToFit()
                .frame(width: 130,height: 130)
                .padding()
            
            // Login information fields.
            VStack {
                
                TextField("Enter your email", text: $viewModel.email)
                    .textInputAutocapitalization(.never)
                    .modifier(CustomTextFieldModifier())
                
                SecureField("Enter your password", text: $viewModel.password)
                    .modifier(CustomTextFieldModifier())
                
                TextField("Enter your username", text: $viewModel.username)
                    .modifier(CustomTextFieldModifier())
                    .textInputAutocapitalization(.never)
                
                TextField("Enter your display name", text: $viewModel.displayName)
                    .modifier(CustomTextFieldModifier())
                
                Button {
                    Task {
                        try await viewModel.createUser()
                    }
                } label: {
                    Text("Sign up")
                        .modifier(ButtonModifier())
                }
                .padding(.vertical)
            }
            
            Spacer()
            
            Divider()
            
            Button {
                dismiss()
            } label: {
                HStack (spacing: 3) {
                    Text("Already have an account?")
                    
                    Text("Sign in")
                        .fontWeight(.semibold)
                }
                .padding(.vertical, 10)
                .foregroundColor(.black)
            }

        }
    }
}

#Preview {
    RegistrationView()
}
