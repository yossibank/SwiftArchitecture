import AppDebug
import SwiftUI

@main
struct MVC: App {
    var body: some Scene {
        WindowGroup {
            MVCView()
        }
        .debugContainer()
    }
}

private extension Scene {
    @MainActor
    func debugContainer() -> some Scene {
        #if DEBUG
            modelContainer(DebugSwiftData.container)
        #else
            self
        #endif
    }
}
