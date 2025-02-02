//
//  ContentView.swift
//  art-impress
//
//  Created by Vadim Komyshenets on 23.01.2025.
//

import SwiftUI

struct OrganizerView: View {
    @EnvironmentObject var appViewModel: AppViewModel
    @State  private  var currentTab:ScreenTab = .feed
    
    var body: some View {
        ZStack(alignment: .leading) {
            
            VStack(spacing: 0) {
                switch currentTab {
                case .feed:
                    ContentView()
                case .newContent:
                    ImageLoadScreen()
                case .about:
                    PersonView(isLogin: $appViewModel.isLogin)
                }
                
                NavigatonBarView(currentTab: $currentTab)
                    .environmentObject(appViewModel)
            }
        }
    }
    
    func color(fraction: Double) -> Color {
        Color(red: fraction, green: 1 - fraction, blue: 0.5)
    }
}

#Preview {
    OrganizerView()
        .environmentObject(AppViewModel())
}
