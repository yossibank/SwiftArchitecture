import AppCore
import Combine
import Rakuten

@MainActor
public final class RakutenViewModel: BaseViewModel<RakutenViewModel> {
    public required init(
        state: State,
        dependency: Dependency
    ) {
        super.init(
            state: state,
            dependency: dependency
        )
    }
}

private extension RakutenViewModel {
    func resetItems() {
        state.loadedItems = []
        state.parameters.nextPage = 1
    }

    func updateItems(_ model: RakutenModel) {
        state.parameters.nextPage = model.currentPage + 1
        state.parameters.maxPage = model.maxPage
        state.loadedItems.append(contentsOf: model.items)
        state.viewState = .loaded(loaded: state.loadedItems)
    }
}

public extension RakutenViewModel {
    func search(isInitial: Bool = true) async {
        if isInitial {
            state.viewState = .initialLoading
            resetItems()
        } else {
            state.viewState = .additionalLoading
        }

        do {
            let model = try await dependency.useCase.search(
                keyword: state.parameters.keyword,
                page: state.parameters.nextPage
            )
            updateItems(model)
        } catch let appError as AppError {
            if isInitial {
                state.viewState = .initialError(appError)
            } else {
                state.viewState = .additionalError(appError)
            }
        } catch {}
    }

    func additionalLoading(_ item: RakutenItem) async {
        guard
            state.loadedItems.last?.id == item.id,
            !state.isFetching,
            !state.parameters.isPageEnd
        else {
            return
        }

        await search(isInitial: false)
    }
}

public extension RakutenViewModel {
    struct State {
        var parameters: Parameters
        var loadedItems: [RakutenItem]
        var viewState: AppPagingState<RakutenItem>

        var isFetching: Bool {
            if case .initialLoading = viewState {
                return true
            }

            if case .additionalLoading = viewState {
                return true
            }

            return false
        }

        public init(
            parameters: Parameters = .init(),
            loadedItems: [RakutenItem] = [],
            viewState: AppPagingState<RakutenItem> = .initial
        ) {
            self.parameters = parameters
            self.loadedItems = loadedItems
            self.viewState = viewState
        }

        public struct Parameters {
            var keyword: String
            var nextPage: Int
            var maxPage: Int

            var isPageEnd: Bool {
                nextPage > maxPage
            }

            public init(
                keyword: String = "",
                nextPage: Int = 1,
                maxPage: Int = 1
            ) {
                self.keyword = keyword
                self.nextPage = nextPage
                self.maxPage = maxPage
            }
        }
    }

    struct Dependency {
        let useCase: any RakutenUseCaseProtocol

        public init(useCase: any RakutenUseCaseProtocol) {
            self.useCase = useCase
        }
    }

    enum Output {
        case showView
    }
}
