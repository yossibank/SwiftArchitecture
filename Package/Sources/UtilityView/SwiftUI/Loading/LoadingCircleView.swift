import SwiftUI

public struct LoadingCircleView: View {
    @State private var isAnimation = false

    public init() {}

    public var body: some View {
        Circle()
            .trim(from: 0.1, to: 1.0)
            .stroke(
                style: .init(
                    lineWidth: 6,
                    lineCap: .round,
                    lineJoin: .round
                )
            )
            .foregroundColor(.gray)
            .rotationEffect(.init(degrees: isAnimation ? 360 : 0))
            .animation(
                .linear(duration: 2.0).repeatForever(
                    autoreverses: false
                ),
                value: isAnimation
            )
            .onAppear {
                isAnimation = true
            }
    }
}

#Preview {
    LoadingCircleView()
        .frame(width: 50, height: 50)
}
