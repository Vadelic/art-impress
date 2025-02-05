import Foundation
import SwiftUI
import SwiftUICore

struct Card: Identifiable {
    let id = UUID()
    let title: String
}

struct RowView: View {
    let cards: [Card]
    let width: CGFloat
    let height: CGFloat
    let horizontalSpacing: CGFloat
    var body: some View {
        HStack(spacing: horizontalSpacing) {
            ForEach(cards) { card in
                CardView(title: card.title)
                    .frame(width: width, height: height)
            }
        }
        .padding()
    }

}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(cards: MockStore.cards, width: 150, height: 150, horizontalSpacing: 5)
    }
}
