//
//  RegistrationView.swift
//  Jook
//
//  Created by iVan on 4/16/24.
//

import SwiftUI

struct RegistrationView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var email = ""
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
                TextField("Enter your username", text: $username)
                    .modifier(CustomTextFieldModifier())
                    .textInputAutocapitalization(.never)
                
                TextField("Enter your email", text: $email)
                    .textInputAutocapitalization(.never)
                    .modifier(CustomTextFieldModifier())
                
                SecureField("Enter your password", text: $password)
                    .modifier(CustomTextFieldModifier())
                
                Button {
                    
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
