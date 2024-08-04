import SwiftUI

public struct AppLoadingView: View {
    public enum LoadingType {
        case circle
        case dots
        case particle
    }

    private let loadingType: LoadingType

    public init(_ loadingType: LoadingType = .dots) {
        self.loadingType = loadingType
    }

    public var body: some View {
        switch loadingType {
        case .circle:
            LoadingCircleView()

        case .dots:
            LoadingDotsView()

        case .particle:
            LoadingParticleView()
        }
    }
}

#Preview {
    VStack(spacing: 64) {
        AppLoadingView(.circle)
            .frame(width: 50, height: 50)

        AppLoadingView(.dots)
            .frame(width: 50, height: 50)

        AppLoadingView(.particle)
            .frame(width: 50, height: 50)
    }
}
