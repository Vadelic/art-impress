//
//  TagView.swift
//  art-impress
//
//  Created by Vadim Komyshenets on 02.02.2025.
//

import SwiftUI


import SwiftUI

struct TagView: View {
    @Binding  var imageTags: ImageTags
    @Binding  var simpleTags: [String]
    @State    var tagsLine: String = ""
    var body: some View {
        VStack(alignment: .leading){
            ForEach($imageTags.tagGroups) { $group in
                TagGroupView(tagGroup: $group)
            }
            
            TextField("tags without categories", text: $tagsLine)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocorrectionDisabled()
                .onChange(of: tagsLine) { newValue in
                        if newValue.last == " " {
                            addTag()
                            tagsLine.removeAll()
                        }
                    }
            
            
            
            
            TagSimpleView(simpleTags:$simpleTags)
        }
    }
    
    func addTag() {
        guard !tagsLine.isEmpty else { return }
        let trimmedText = tagsLine.trimmingCharacters(in: .whitespaces)
        if !simpleTags.contains(trimmedText) {
            simpleTags.append(trimmedText)
        }
        tagsLine.removeAll()
    }
}


#Preview {
    TagView(imageTags: .constant(MockStore.tags), simpleTags: .constant(["sdcsd","sdf"]))
}
