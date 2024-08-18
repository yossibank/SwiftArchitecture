import AppDebug
import SwiftUI

@main
struct MVVM: App {
    var body: some Scene {
        WindowGroup {
            MVVMView()
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
