import AppDebug
import SwiftUI

@main
struct Flux: App {
    var body: some Scene {
        WindowGroup {
            FluxView()
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
