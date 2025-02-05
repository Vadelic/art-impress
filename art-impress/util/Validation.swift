//
//  Validation.swift
//  art-impress
//
//  Created by Vadim Komyshenets on 24.01.2025.
//


 func validateEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return email.range(of: emailRegEx, options: .regularExpression) != nil
    }