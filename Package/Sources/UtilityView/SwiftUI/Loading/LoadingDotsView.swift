import SwiftUI
import Utility

public struct LoadingDotsView: View {
    @State private var offsetY1: CGFloat = 0.0
    @State private var offsetY2: CGFloat = 0.0
    @State private var offsetY3: CGFloat = 0.0

    private let dotSize: CGFloat = 20.0
    private let distance: CGFloat = 20.0
    private let duration = 0.5
    private let delay = 0.2

    private enum Dots {
        case dot1
        case dot2
        case dot3
    }

    public init() {}

    public var body: some View {
        HStack(spacing: 20) {
            dotView
                .offset(y: offsetY1)

            dotView
                .offset(y: offsetY2)

            dotView
                .offset(y: offsetY3)
        }
        .padding(.top, -(dotSize * 2))
        .onAppear {
            dotAnimation(dots: .dot1)

            Task { @MainActor in
                try await Task.sleep(seconds: delay)
                dotAnimation(dots: .dot2)
            }

            Task { @MainActor in
                try await Task.sleep(seconds: delay * 2)
                dotAnimation(dots: .dot3)
            }
        }
    }

    private var dotView: some View {
        Circle()
            .frame(width: dotSize, height: dotSize)
            .foregroundStyle(.gray)
    }

    private func dotAnimation(dots: Dots) {
        withAnimation(.easeOut(duration: duration).repeatForever(autoreverses: true)) {
            switch dots {
            case .dot1:
                offsetY1 = distance

            case .dot2:
                offsetY2 = distance

            case .dot3:
                offsetY3 = distance
            }
        }
    }
}

#Preview {
    LoadingDotsView()
}
