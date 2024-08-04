import SwiftUI

public extension View {
    func showToast(
        isShown: Binding<Bool>,
        toastType: ToastType,
        message: String? = nil
    ) -> some View {
        modifier(
            ToastModifier(
                isShown: isShown,
                toastType: toastType,
                message: message
            )
        )
    }
}

public struct ToastModifier: ViewModifier {
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

    public func body(content: Content) -> some View {
        ZStack(alignment: .top) {
            content

            if isShown {
                ToastView(
                    isShown: _isShown,
                    toastType: toastType,
                    message: message
                )
                .frame(maxWidth: .infinity)
                .padding()
            }
        }
    }
}
