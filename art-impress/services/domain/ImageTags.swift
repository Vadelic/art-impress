//
//  ImageTags.swift
//  art-impress
//
//  Created by Vadim Komyshenets on 06.02.2025.
//


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
    var selected: Bool
    
    init(_ name: String, _ isSelected: Bool) {
        self.name = name
        self.selected = isSelected
    }
    // Этот метод нужен для обновления значений тегов
    mutating func update( value: Bool) {
        self.selected = value
    }
}