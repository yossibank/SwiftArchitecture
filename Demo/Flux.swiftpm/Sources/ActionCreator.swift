import Combine
import Rakuten

final class FluxActionCreator {
    private let service: RakutenUseCase
    private let dispatcher: FluxDispatcher

    init(
        service: RakutenUseCase = .instance(),
        dispatcher: FluxDispatcher = .shared
    ) {
        self.service = service
        self.dispatcher = dispatcher
    }

    func onAppear() async {
        let model = try? await service.search(
            keyword: "からあげ",
            page: 1
        )
        let items = model?.items ?? []

        dispatcher.dispatch(.search(items))
    }
}
