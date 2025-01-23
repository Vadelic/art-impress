//
//  RergistrationForm.swift
//  art-impress
//
//  Created by Vadim Komyshenets on 22.01.2025.
//
import SwiftUI

struct RegistrationForm: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var rePassword: String = ""
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Text("Registration")
                .font(.title)
            
            TextField("login or email", text: $email)
                .frame(width: 300.0)
                .font(.system(size: 18) )
                .autocapitalization(.none)
//                .onChange(of: email) {oldState, newState in
//                    validateEmail()
//                }
            TextField("name", text: $email)
                .frame(width: 300.0)
                .font(.system(size: 18) )
                .autocapitalization(.none)
            
            SecureField("password", text: $password)
                .frame(width: 300.0)
                .font(.system(size: 18) )
               
           
            SecureField("re-password", text: $rePassword)
                .frame(width: 300.0)
                .font(.system(size: 18) )
                

            Button("Sign up") {
                presentationMode.wrappedValue.dismiss()
            }
            .foregroundColor(.black)
            .font(.callout)
            .buttonStyle(.bordered)
        }.textFieldStyle(.roundedBorder)

    }
}

struct RegistrationForm_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationForm()
    }
}
