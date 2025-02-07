import SwiftUI

struct NavigatonBarView: View {
    @Binding       var currentTab: ScreenTab
    @State private var isShowingSheet = false
    
    
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: "house")
                .resizable()
                .frame(width: 30, height: 25)
                .padding( 8)
                .onTapGesture {
                    withAnimation {
                        print("feed click")
                        currentTab = .feed
                    }
                }
            Spacer()
            Image(systemName: "plus.circle")
                .resizable()
                .frame(width: 25, height: 25)
                .padding( 8)
                .sheet(isPresented: $isShowingSheet) {
                    ImageLoadScreen()
                }
            
                .onTapGesture {
                    withAnimation {
                        isShowingSheet.toggle()
                    }
                }
            
            Spacer()
            Image(systemName: "person")
                .resizable()
                .frame(width: 25, height: 25)
                .padding( 8)
                .onTapGesture {
                    withAnimation {
                        print("about click")
                        currentTab = .about
                    }
                }
        }
        
    }
}


struct NavigatonBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigatonBarView(currentTab: .constant(ScreenTab.about))
    }
}
