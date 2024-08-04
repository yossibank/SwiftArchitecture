import Rakuten
import SwiftUI
import UtilityView

public struct RakutenView: View {
    @StateObject private var viewModel: RakutenViewModel

    @State private var isShowToast = false

    @Environment(\.isSearching) private var isSearching

    public init(viewModel: RakutenViewModel) {
        _viewModel = .init(wrappedValue: viewModel)
    }

    public var body: some View {
        GeometryReader { proxy in
            ScrollView {
                switch viewModel.state.viewState {
                case .initial:
                    InitialView()
                        .frame(proxy: proxy)

                case .initialLoading:
                    AppLoadingView()
                        .frame(proxy: proxy)

                case .additionalLoading:
                    VStack {
                        ItemsView(
                            viewModel: viewModel,
                            items: viewModel.state.loadedItems
                        )

                        AppLoadingView(.circle)
                            .padding(.vertical, 16)
                            .frame(height: 80)
                    }

                case let .initialError(appError):
                    AppErrorView(
                        message: String(describing: appError),
                        didTapReloadButton: {
                            Task { @MainActor in
                                await viewModel.search(isInitial: true)
                            }
                        }
                    )
                    .frame(proxy: proxy)

                case .additionalError:
                    ItemsView(
                        viewModel: viewModel,
                        items: viewModel.state.loadedItems
                    )
                    .onAppear {
                        isShowToast = true
                    }

                case let .loaded(items):
                    if items.isEmpty {
                        AppNoResultView(title: "商品が見つかりませんでした")
                            .frame(proxy: proxy)
                    } else {
                        ItemsView(
                            viewModel: viewModel,
                            items: items
                        )
                    }
                }
            }
            .searchable(
                text: .init(
                    get: {
                        viewModel.state.parameters.keyword
                    },
                    set: { text in
                        viewModel.state.parameters.keyword = text
                    }
                ),
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "商品検索"
            )
            .onSubmit(of: .search) {
                Task { @MainActor in
                    await viewModel.search(isInitial: true)
                }
            }
            .showToast(
                isShown: $isShowToast,
                toastType: .error,
                message: "追加読み込み失敗"
            )
        }
    }

    private struct InitialView: View {
        var body: some View {
            VStack(spacing: 24) {
                Image(.penguin)
                    .resizable()
                    .frame(width: 80, height: 80)

                Text("商品を検索してください")
                    .bold()
            }
        }
    }

    private struct ItemsView: View {
        @ObservedObject var viewModel: RakutenViewModel

        let items: [RakutenItem]

        var body: some View {
            LazyVStack(spacing: 16) {
                ForEach(items, id: \.self) { item in
                    ItemView(item: item)
                        .onAppear {
                            Task { @MainActor in
                                guard item == viewModel.state.loadedItems.last else {
                                    return
                                }

                                await viewModel.additionalLoading(item)
                            }
                        }
                }
            }
        }
    }

    private struct ItemView: View {
        let item: RakutenItem

        var body: some View {
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

#Preview {
    NavigationStack {
        RakutenView(
            viewModel: .init(
                state: .init(),
                dependency: .init(useCase: RakutenUseCase.instance())
            )
        )
    }
}
