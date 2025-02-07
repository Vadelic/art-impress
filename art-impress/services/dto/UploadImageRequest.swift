//
//  UploadImageRequest.swift
//  art-impress
//
//  Created by Vadim Komyshenets on 06.02.2025.
//


struct UploadImageRequest: Codable {
    let structuredTags: ImageTags
    let tags: [String]
    init(structuredTags: ImageTags?, tags: [String]?) {
        let modifiedStructuredTags = structuredTags
        // Проходимся по каждой группе и удаляем ненужные теги
        if var modifiedStructuredTags = modifiedStructuredTags {
            for i in 0..<modifiedStructuredTags.tagGroups.count {
                var group = modifiedStructuredTags.tagGroups[i]
                group.tags.removeAll(where: { $0.selected == false })
                modifiedStructuredTags.tagGroups[i] = group
            }
            modifiedStructuredTags.tagGroups.removeAll(where: { $0.tags.isEmpty })
            // Присваиваем измененный объект structuredTags
            self.structuredTags = modifiedStructuredTags
            
        }else{
            self.structuredTags = ImageTags(tagGroups: [])
        }
        self.tags = tags ?? []
    }
}
