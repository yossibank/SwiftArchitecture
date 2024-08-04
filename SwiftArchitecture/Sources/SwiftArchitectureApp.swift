import AppDebug
import Rakuten
import RakutenView
import SwiftData
import SwiftUI

@main
struct SwiftArchitectureApp: App {
    @State private var isShowDebugView = false

    var body: some Scene {
        WindowGroup {
            RakutenViewRepresentable(
                viewModel: .init(
                    state: .init(),
                    dependency: .init(useCase: RakutenUseCase.instance())
                )
            )
            .onShake {
                isShowDebugView.toggle()
            }
            .sheet(
                isPresented: $isShowDebugView,
                content: {
                    DebugView()
                }
            )
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
