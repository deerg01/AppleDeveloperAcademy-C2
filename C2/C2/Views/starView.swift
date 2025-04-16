import SwiftUI
import SwiftData

struct starView: View {
    @State private var navToMenu = false // navigatie to menuView
    @GestureState private var dragOffset = CGSize.zero
    @State private var path = NavigationPath() // past navigation path
    

    var body: some View {
        ZStack {
            LinearGradient( // background
                stops: [
                    Gradient.Stop(color: Color(red: 0.14, green: 0.11, blue: 0.3), location: 0.00),
                    Gradient.Stop(color: Color(red: 0, green: 0.45, blue: 1), location: 1.00),
                ],
                startPoint: UnitPoint(x: 0.5, y: 0.37),
                endPoint: UnitPoint(x: 0.5, y: 1)
            )
            .ignoresSafeArea()
            
            Text("Hello, World!")
                .foregroundColor(.white)
                .font(.largeTitle)
                .padding()
        }
        .gesture( // navigate to menuView on Drag
            DragGesture()
                .updating($dragOffset) { value, state, _ in
                    if value.translation.width > 10 { // left to right swipe
                        state = value.translation
                    }
                }
                .onEnded { value in
                    if value.translation.width > 70 {
                        withAnimation(.easeInOut) {
                            navToMenu = true
                        }
                    }
                }
        )
        .navigationDestination(isPresented: $navToMenu) {
            menuView()
                .transition(.move(edge: .trailing))
        }
    }
}


#Preview {
    starView()
}
