//
//  ContentView.swift
//  art-impress
//
//  Created by Vadim Komyshenets on 21.01.2025.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var appViewModel: AppViewModel
    @State  var email: String = ""
    @State  var password: String = ""
    @State private var isValidEmail = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var showSecondScreen = false
  
    var body: some View {
        VStack(alignment: .center, spacing: 10)
        {
            Image("logo")
                .resizable()
                .frame(width: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/)
                .clipShape(Circle())
            
            TextField("login or e-mail", text: $email)
                .frame(width: 300.0)
                .font(.system(size: 18) )
               .autocapitalization(.none)
                .onChange(of: email) {oldState, newState in
                    validateEmail()
                }
            
            
            if !isValidEmail && !email.isEmpty {
                Text("Incorrect email")
                    .font(.footnote)
                    .foregroundColor(.red)
            }
            
            SecureField("password", text: $password)
                .frame(width: 300.0)
                .font(.system(size: 18) )
              
            
            Button("Login",action: {
                Task {
                    await sendDataToService()
                    appViewModel.isLogin = true
                }
            })

//            .foregroundColor(.black)
            .buttonStyle(.bordered)
            .disabled(!isValidEmail || email.isEmpty || password.isEmpty)
            
            Button("Sign up",action: {
                Task {
                    showSecondScreen = true
                }
            })
            .sheet(isPresented: $showSecondScreen) {
                RegistrationForm()
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
            
            
        }.textFieldStyle(.roundedBorder)
        
    }
    func validateEmail() {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        if let _ = email.range(of: emailRegEx, options: .regularExpression) {
            isValidEmail = true
        } else {
            isValidEmail = false
        }
    }
    func sendDataToService() async {
        // Имитация отправки данных на сервер
        do {
            let url = URL(string: "https://art-impress.com/auth/login")!
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let body: [String: String] = ["email": email, "password": password]
            let jsonBody = try JSONSerialization.data(withJSONObject: body, options: [])
            request.httpBody = jsonBody
            
            let (_, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                self.alertMessage = "Ошибка при отправке данных. Пожалуйста, попробуйте позже."
                self.showAlert = true
                return
            }
            
            print("Данные успешно отправлены!")
        } catch {
            self.alertMessage = "Произошла ошибка при обработке запроса: \(error.localizedDescription)"
            self.showAlert = true
        }
    }
    
}




#Preview {
      LoginView(email: "art@impress.com", password: "123")
}
