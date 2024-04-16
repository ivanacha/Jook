//
//  LoginView.swift
//  Jook
//
//  Created by iVan on 4/16/24.
//

import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    
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
                    TextField("Enter your username", text: $username)
                        .textInputAutocapitalization(.never)
                        .modifier(CustomTextFieldModifier())
                    
                    SecureField("Enter your password", text: $password)
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
