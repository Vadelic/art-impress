//
//  User.swift
//  art-impress
//
//  Created by Vadim Komyshenets on 23.01.2025.
//

import Foundation
import FirebaseAuth

class AppViewModel: ObservableObject{
    @Published var isLogin =  UserDefaults.standard.value(forKey: "isLogin") as? Bool ?? false
    @Published var user :User?
}

//struct User{
//    var name:String
//    var login:String
//    var imageName:String?
//}
