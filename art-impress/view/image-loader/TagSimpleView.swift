//
//  TagView.swift
//  art-impress
//
//  Created by Vadim Komyshenets on 02.02.2025.
//

import SwiftUI


import SwiftUI

struct TagSimpleView: View {
    @Binding  var simpleTags: [String]
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 5) {
                    ForEach(simpleTags, id: \.self) { tagName in
                        TagRemovableButton(name: tagName) {
                            if let index = simpleTags.firstIndex(of: tagName) {
                                simpleTags.remove(at: index)
                            }
                        }
                    }
                }
            }
        }
    }
    
}

struct TagRemovableButton: View {
    var name: String
    let onRemove: () -> Void
    
    var body: some View {
        
        Button(action: {  }) {
            Text(name)
                .foregroundColor(.white)
                .padding(6)
                .frame(minWidth: 80)
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.blue)
                )
        }.contentShape(Rectangle())
            .simultaneousGesture(
                LongPressGesture(minimumDuration: 0.7)
                    .onEnded({_ in
                        print("long press TAG \(name)")
                        onRemove()
                    }))
        
        
        
        
        
    }
}

#Preview {
    TagSimpleView(simpleTags: .constant(["0ssds","asdasd"]))
}
#Preview {
    TagRemovableButton(name: "name",onRemove: {print("dd")})
    
}
