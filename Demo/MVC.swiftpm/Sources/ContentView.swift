import SwiftUI
import Utility

struct ContentView: View {
    var body: some View {
        VStack {
            Image(.information)
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
    }
}
