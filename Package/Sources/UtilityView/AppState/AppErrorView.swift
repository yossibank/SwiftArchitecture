import SwiftUI
import Utility

public struct AppErrorView: View {
    private let message: String?
    private let didTapReloadButton: VoidBlock

    public init(
        message: String?,
        didTapReloadButton: @escaping VoidBlock
    ) {
        self.message = message
        self.didTapReloadButton = didTapReloadButton
    }

    public var body: some View {
        VStack(spacing: 24) {
            Image(.penguin)
                .resizable()
                .frame(width: 80, height: 80)

            Text("エラーが発生しました")
                .font(.headline)

            VStack(spacing: 8) {
                Text("原因")
                    .font(.subheadline)
                    .bold()

                Text(message ?? "原因不明")
                    .font(.subheadline)
                    .bold()
            }
            .padding(16)
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.pink, lineWidth: 1)
            }

            Button {
                didTapReloadButton()
            } label: {
                Text("リロード")
                    .font(.subheadline)
                    .bold()
                    .foregroundStyle(.pink)
                    .padding(8)
                    .overlay {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.pink, lineWidth: 1)
                    }
            }
        }
    }
}

#Preview {
    AppErrorView(message: "なんらかのエラーです") {}
}
