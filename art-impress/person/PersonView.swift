//
//  MenuItem.swift
//  art-impress
//
//  Created by Vadim Komyshenets on 24.01.2025.
//

import Foundation
import SwiftUI

// Представление боковой панели
struct PersonView: View {
    @Binding var isLogin: Bool
    
    var body: some View {
        
        VStack {
            Text("Profile info")
                .font(.body)
                .padding()
            
            Divider()
            Spacer()
           
            Button(action:  {isLogin=false}) {
                Text("Log Out")
                    .foregroundStyle(.red)
                    .font(.body)
                    .padding()
            }
        }
    }
}

#Preview {
    PersonView(isLogin: .constant(true))
}


