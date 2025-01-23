//
//  art_impressApp.swift
//  art-impress
//
//  Created by Vadim Komyshenets on 21.01.2025.
//

import SwiftUI

@main
struct art_impressApp: App {
   @ObservedObject var appViewModel = AppViewModel()
    var body: some Scene {
        WindowGroup {
            if appViewModel.isLogin{
            ContentView()
            } else{
                LoginView()
                    .environmentObject(appViewModel)
            }
        }
    }
}
