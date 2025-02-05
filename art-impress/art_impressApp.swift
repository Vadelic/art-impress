//
//  art_impressApp.swift
//  art-impress
//
//  Created by Vadim Komyshenets on 21.01.2025.
//

import SwiftUI
import FirebaseCore
import GoogleSignIn

@main
struct art_impressApp: App {
    @ObservedObject var appViewModel = AppViewModel()
   
    init() {
           // Firebase initialization
           FirebaseApp.configure()
       }

    var body: some Scene {
        WindowGroup {
             
            if appViewModel.isLogin{
                OrganizerView()
                    .environmentObject(appViewModel)
              
            } else{
                LoginView()
                    .environmentObject(appViewModel)
            
            }
        }
    }
}
