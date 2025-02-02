//
//  ContentView.swift
//  art-impress
//
//  Created by Vadim Komyshenets on 21.01.2025.
//

import SwiftUI
import FirebaseAuth
import FirebaseCore
import GoogleSignIn


struct LoginView: View {
    @EnvironmentObject var appViewModel: AppViewModel
    @Environment(\.colorScheme) var colorScheme // Получаем текущую схему устройства
    @State  var email: String = ""
    @State  var password: String = ""
    @State  var isValidEmail = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var showSecondScreen = false
  
  
    var body: some View {
        VStack(alignment: .center, spacing: 10)
        {
            
            let logoImg =  Image("logo")
                .resizable()
                .frame(width: 200, height: 200)
                .clipShape(Circle())
            
            if colorScheme == .dark {
                logoImg.colorInvert()
            }else{
                logoImg
            }
            
            TextField("login or e-mail", text: $email)
                .frame(width: 300.0)
                .font(.system(size: 14))
                .padding([.bottom, .trailing, .leading   ], 8)
                .autocapitalization(.none)
                .onChange(of: email) {oldState, newState in
                    //                    isValidEmail =  validateEmail(email: email)
                    isValidEmail =  true
                }
            
            
            if !isValidEmail && !email.isEmpty {
                Text("Incorrect email")
                    .font(.footnote)
                    .foregroundColor(.red)
            }
            
            SecureField("password", text: $password)
                .frame(width: 300.0)
                .font(.system(size: 14))
                .padding([.bottom, .trailing, .leading   ], 8)
            
// login with email
            Button("Login",action: {
                signInWithEmail(email: email, password: password) { (verified, status) in
                    if !verified {
                        self.alertMessage = status
                        self.showAlert.toggle()
                    }
                    else{
                   // appViewModel.user = user
                        UserDefaults.standard.setValue(true, forKey: "isLogin")
                        appViewModel.isLogin = true
                        
                    }
                }
            })
            .buttonStyle(.bordered)
            .disabled(!isValidEmail || email.isEmpty || password.isEmpty)
            
           
//Continue with Google
            Button("Continue with Google",action: {Task {
                do {
                    try await Authentication().googleOauth()
                } catch AuthenticationError.runtimeError(let errorMessage) {
                    //  err = errorMessage
                    print(errorMessage)
                }
            }  })
            .buttonStyle(.bordered)
      
            
            HStack(spacing: 8){
                Text("Don't Have An Account ?").foregroundColor(Color.gray.opacity(0.5))
                Button("Sign up",action: {
                    Task {
                        showSecondScreen = true
                    }
                })}
            
            
            .sheet(isPresented: $showSecondScreen) {
                RegistrationForm() .environmentObject(appViewModel)
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
            
            
        }.textFieldStyle(.roundedBorder)
           
    }
    
    
    
}

// MARK: - SineIn Google

func signInWithGoogle(completion: @escaping (Bool,String)->Void){
    completion(true, "noname")
 }

// MARK: - SineIn mail
func signInWithEmail(email: String,password : String,completion: @escaping (Bool,String)->Void){
    Auth.auth().signIn(withEmail: email, password: password) { (res, err) in
        if err != nil{
            completion(false,(err?.localizedDescription)!)
            return
        }
        completion(true,(res?.user.email)!)
    }
}



#Preview {
    LoginView(email: "art@impress.com", password: "123", isValidEmail:true)
}
