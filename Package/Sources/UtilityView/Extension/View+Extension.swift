import SwiftUI

public extension View {
    func frame(
        proxy: GeometryProxy,
        alignment: Alignment = .center
    ) -> some View {
        frame(
            width: proxy.size.width,
            height: proxy.size.height,
            alignment: alignment
        )
    }
}
