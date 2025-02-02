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
        ZStack(alignment: .top) {
            if isShowing {
                Rectangle()
                    .fill(type.backgroundColor)
                    .overlay(
                        Text(message)
                            .foregroundColor(type.textColor)
                            .font(.headline)
                            .multilineTextAlignment(.center)
                            .padding()
                    )
                    .transition(.move(edge: .top))
                    .animation(.easeInOut(duration: 0.3), value: isShowing)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            withAnimation {
                                isShowing = false
                            }
                        }
                    }
            }
            
            EmptyView()
        }
        .ignoresSafeArea(edges: .top)
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
