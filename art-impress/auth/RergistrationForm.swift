//
//  RergistrationForm.swift
//  art-impress
//
//  Created by Vadim Komyshenets on 22.01.2025.
//
import SwiftUI
import FirebaseAuth

struct RegistrationForm: View {
    @EnvironmentObject var appViewModel: AppViewModel
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var rePassword: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("Registration")
                .font(.title)
            
            TextField("login or email", text: $email)
                .autocapitalization(.none)
                .font(.system(size: 14))
                .padding([.bottom, .trailing, .leading   ], 8)
           
            SecureField("password", text: $password)
                .autocapitalization(.none)
                .font(.system(size: 14))
                .padding([.bottom, .trailing, .leading   ], 8)
          
            
            SecureField("re-password", text: $rePassword)
                .autocapitalization(.none)
                .font(.system(size: 14))
                .padding([.bottom, .trailing, .leading   ], 8)
                
            
            
            Button("Sign up") {
                Task{
                    signUpWithEmail(email: email, password: password) { (verified, status) in
                        if !verified {
                            print("проблема с регистрацией")
                            self.alertMessage = status
                            self.showAlert.toggle()
                        }
                        else{
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }}
            //            .foregroundColor(.black)
            
            .font(.callout)
            .buttonStyle(.bordered)
            .disabled(password != rePassword || email.isEmpty ||  password.isEmpty)
            .alert(isPresented: $showAlert) {
                Alert(title: Text(alertMessage), dismissButton: .default(Text("OK")))}
            
        }.textFieldStyle(.roundedBorder)
        
    }
}


func signUpWithEmail(email: String,password : String,completion: @escaping (Bool,String)->Void){
    
    Auth.auth().createUser(withEmail: email, password: password) { (res, err) in
        
        if err != nil{
            
            completion(false,(err?.localizedDescription)!)
            return
        }
        
        completion(true,(res?.user.email)!)
    }
}

struct RegistrationForm_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationForm()
    }
}
