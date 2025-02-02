//
//  ImageModel.swift
//  art-impress
//
//  Created by Vadim Komyshenets on 27.01.2025.
//

import Foundation

struct ImageTags{
    
}

struct UploadImageRequest: Codable {
    let id: String?
    let hashTags: [String]?
}

