import SwiftUI

struct CardView: View {
    let title: String
    var body: some View {
        RoundedRectangle(cornerRadius: 12).foregroundColor(.random)
        
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(title: "Hello world")
    }
}

extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}
