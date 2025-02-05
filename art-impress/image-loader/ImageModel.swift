//
//  ImageModel.swift
//  art-impress
//
//  Created by Vadim Komyshenets on 27.01.2025.
//

import Foundation

struct ImageTags:Decodable,Encodable{
    var  tagGroups:[TagGroup]
}

struct TagGroup: Identifiable,Decodable,Encodable{
    var id: String{get{name}}
    var name: String
    var tags: [Tag]
    
}
struct Tag: Identifiable,Decodable,Encodable{
    var id: String{get{name}}
    var name: String
    var isSelected: Bool
    
    init(_ name: String, _ isSelected: Bool) {
        self.name = name
        self.isSelected = isSelected
    }
    // Этот метод нужен для обновления значений тегов
    mutating func update( value: Bool) {
        self.isSelected = value
    }
}

struct UploadImageRequest: Codable {
    let structuredTags: ImageTags?
    let tags: [String]?
    init(structuredTags: ImageTags?, tags: [String]?) {
        let modifiedStructuredTags = structuredTags
        
        // Проходимся по каждой группе и удаляем ненужные теги
        if var modifiedStructuredTags = modifiedStructuredTags {
            for i in 0..<modifiedStructuredTags.tagGroups.count {
                var group = modifiedStructuredTags.tagGroups[i]
                group.tags.removeAll(where: { $0.isSelected == false })
                modifiedStructuredTags.tagGroups[i] = group
            }
            modifiedStructuredTags.tagGroups.removeAll(where: { $0.tags.isEmpty })
            // Присваиваем измененный объект structuredTags
            self.structuredTags = modifiedStructuredTags
            
        }else{
            self.structuredTags = nil
        }
        self.tags = tags
    }
}

