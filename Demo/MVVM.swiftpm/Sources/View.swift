import SwiftUI
import UtilityView

struct MVVMView: View {
    private let viewModel = MVVMViewModel()

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(viewModel.items, id: \.self) { item in
                    VStack(alignment: .center) {
                        HStack(alignment: .top, spacing: 12) {
                            AsyncImageView(
                                url: item.imageURL,
                                successImage: { image in
                                    image.resizable()
                                }
                            )
                            .frame(width: 120, height: 120)
                            .clipShape(RoundedRectangle(cornerRadius: 4))

                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.system(size: 16, weight: .bold))
                                    .lineLimit(4)

                                Spacer()

                                HStack(alignment: .bottom) {
                                    Spacer()

                                    Text(item.price)
                                        .font(.system(size: 18, weight: .bold))
                                        .foregroundStyle(.red)
                                }
                            }
                        }
                        .padding(.horizontal, 16)

                        Divider()
                    }
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.search()
            }
        }
    }
}
