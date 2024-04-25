//
//  LoginView.swift
//  Jook
//
//  Created by iVan on 4/16/24.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationStack {
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
                }
                
                NavigationLink {
                    Text("Forgot Password")
                } label: {
                    Text("Forgot Password?")
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                        .font(.footnote)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.vertical, 10)
                        .padding(.trailing, 25)
                }
                
                // Login button.
                Button {
                    Task { try await viewModel.login() }
                } label: {
                    Text("Login")
                        .modifier(ButtonModifier())
                }
                
                Spacer()
                
                Divider()
                
                NavigationLink {
                    RegistrationView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack (spacing: 3) {
                        Text("Create a new account")
                            .foregroundStyle(.black)
                            .bold()
                    } .padding(.vertical, 10)
                }

            }
        }
    }
}

#Preview {
    LoginView()
}
