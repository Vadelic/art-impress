//
//  TagView.swift
//  art-impress
//
//  Created by Vadim Komyshenets on 02.02.2025.
//

import SwiftUI


import SwiftUI

struct TagGroupView: View {
    @Binding  var tagGroup: TagGroup
    var body: some View {
        VStack(alignment: .leading) {
            Text(tagGroup.name)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 5) {
                    ForEach($tagGroup.tags) { $tag in
                        TagButton(name: tag.name, selection: $tag.selected)
                    }
                }
            }
        }
    }
}

struct TagButton: View {
    var name: String
    @Binding  var selection:Bool
    var body: some View {
        
        Button(action: {
            selection.toggle()
            print("press TAG \(name)")
        }) {
            Text(name)
                .foregroundColor(.white)
                .padding(6)
                .frame(minWidth: 80)
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.blue.opacity(selection ? 1 : 0.5))
                )
        }
    }
}

#Preview {
    TagGroupView(tagGroup: .constant(MockStore.tags.tagGroups[0]))
}
#Preview {
    TagButton(name: "name", selection: .constant(true))
    TagButton(name: "name", selection: .constant(false))
}
