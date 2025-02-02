//
//  ContentGalleryView.swift
//  art-impress
//
//  Created by Vadim Komyshenets on 24.01.2025.
//

import SwiftUI

struct GalleryView: View {
    
        // 1. Static data
        let itemPerRow: CGFloat = 2
        let horizontalSpacing: CGFloat = 16
        let height: CGFloat = 160
        // 2. Sample data for cards
        let cards: [Card] = MockStore.cards
    
    var body: some View {
            // 3. Use geometry to calculate width of the cards based on itemPerRow
        GeometryReader { geometry in
                ScrollView {
                    // 4. Iterate cards and fillup in the VStack
                    VStack(alignment: .leading, spacing: 1) {
                        ForEach(0..<cards.count) { i in
                            // 5. Process the first index of each row
                            if i % Int(itemPerRow) == 0 {
                                // 6. Get view
                                buildView(rowIndex: i, geometry: geometry)
                            }
                        }
                    }
                }
            }
        }
        // 8. Iterate data and see if got more index
        func buildView(rowIndex: Int, geometry: GeometryProxy) -> RowView? {
            var rowCards = [Card]()
            for itemIndex in 0..<Int(itemPerRow) {
                // 8. Check if got two item in counts, then insert it properly
                if rowIndex + itemIndex < cards.count {
                    rowCards.append(cards[rowIndex + itemIndex])
                }
            }
            if !rowCards.isEmpty {
                return RowView(cards: rowCards, width: getWidth(geometry: geometry), height: height, horizontalSpacing: horizontalSpacing)
            }
            print("init cardView:")
            return nil
        }
        
        func getWidth(geometry: GeometryProxy) -> CGFloat {
            let width: CGFloat = (geometry.size.width - horizontalSpacing * (itemPerRow + 1)) / itemPerRow
            return width
        }
    }

    struct GalleryView_Previews: PreviewProvider {
        static var previews: some View {
            GalleryView()
        }
    }

