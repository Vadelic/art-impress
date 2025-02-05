//
//  TopNotificationView.swift
//  art-impress
//
//  Created by Vadim Komyshenets on 01.02.2025.
//


import SwiftUI

struct TopNotificationView: View {
    
    @Binding var isShowing: Bool
    let message: String
    let type: NotificationType
    
    var body: some View {
        VStack(spacing: 0) {
            if isShowing {
                Rectangle()
                    
                    .fill(type.backgroundColor)
                    .frame(height: 60)
                    .overlay(
                        Text(message)
                            .foregroundColor(type.textColor)
                            .font(.headline)
                            .multilineTextAlignment(.center)
                            .padding()
                    )
                    
                    .opacity(isShowing ? 1 : 0)

                    .animation(.easeInOut(duration: 0.8), value: isShowing)
                    
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            withAnimation {
                                isShowing = false
                            }
                        }
                    }
                    .padding([.leading, .trailing], 10)
            }
            
            Spacer(minLength: 0)
        }
//        .ignoresSafeArea(edges: .top)
    }
}

enum NotificationType {
    case success
    case error
    
    var backgroundColor: Color {
        switch self {
        case .success:
            return .green
        case .error:
            return .red
        }
    }
    
    var textColor: Color {
        switch self {
        case .success:
            return .white
        case .error:
            return .white
        }
    }
}

struct ContentViewtest: View {
    
    @State private var showSuccessNotification = false
    @State private var showErrorNotification = false
    
    var body: some View {
        VStack {
            Button("Показать успешное уведомление") {
                showSuccessNotification.toggle()
            }
            .padding()
            
            Button("Показать ошибку") {
                showErrorNotification.toggle()
            }
            .padding()
            
            Spacer()
        }
        .overlay(TopNotificationView(isShowing: $showSuccessNotification, message: "Успех! Действие выполнено.", type: .success))
        .overlay(TopNotificationView(isShowing: $showErrorNotification, message: "Ошибка! Произошла непредвиденная ошибка.", type: .error))
    }
}

struct ContentViewtest_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewtest()
    }
}
