import AppDebug
import SwiftUI

@main
struct MVP: App {
    var body: some Scene {
        WindowGroup {
            MVPView()
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
