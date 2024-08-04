import SwiftUI

public struct ToastView: View {
    @Binding private var isShown: Bool

    private let toastType: ToastType
    private let message: String?

    public init(
        isShown: Binding<Bool>,
        toastType: ToastType,
        message: String? = nil
    ) {
        self._isShown = isShown
        self.toastType = toastType
        self.message = message
    }

    public var body: some View {
        HStack(spacing: 16) {
            toastType.image
                .resizable()
                .scaledToFit()
                .frame(height: 32)

            VStack(alignment: .leading, spacing: 4) {
                Text(toastType.title)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(.white)

                if let message {
                    Text(message)
                        .font(.system(size: 13, weight: .bold))
                        .foregroundStyle(.white)
                }
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 28)
        .background(toastType.style)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .onTapGesture {
            withAnimation {
                isShown = false
            }
        }
        .onAppear {
            Task { @MainActor in
                try? await Task.sleep(for: .seconds(3))

                withAnimation {
                    isShown = false
                }
            }
        }
    }
}

#Preview {
    ToastView(
        isShown: .constant(true),
        toastType: .done,
        message: "タスクが終わりました"
    )
}
