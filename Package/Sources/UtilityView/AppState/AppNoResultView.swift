import SwiftUI

public struct AppNoResultView: View {
    private let title: String

    public init(title: String) {
        self.title = title
    }

    public var body: some View {
        VStack(spacing: 24) {
            Image(.penguin)
                .resizable()
                .frame(width: 80, height: 80)

            Text(title)
                .font(.headline)
                .bold()
                .padding(16)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.pink, lineWidth: 1.0)
                }
                .padding(16)
        }
    }
}

#Preview {
    AppNoResultView(title: "商品が見つかりませんでした")
}
