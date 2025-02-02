//
//  ContentGalleryView.swift
//  art-impress
//
//  Created by Vadim Komyshenets on 24.01.2025.
//

import SwiftUI

struct ContentView: View {
    
    
    var body: some View {
       
            VStack{
                SearchBarView()
                GalleryView()
            }
        }
}
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }

