import SwiftUI

struct SearchBarView: View {
 
    @State private var searchText = ""

    
    var body: some View {
        

        HStack(alignment: .center) {
         
            Image("logo")
                .resizable()
                .frame(width: 25, height: 25)
                .padding(.leading, 8)
        
            TextField("Search...", text: $searchText)
                .font(.system(size: 14))
                .foregroundColor(Color.primary)
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray.opacity(0.15))
                )
                .padding( 12)

            Spacer()
            
        }
        .frame(height: 60)
        .shadow( radius: 4, x: 0, y: 2)
        
        
    }
}


struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView()
    }
}
