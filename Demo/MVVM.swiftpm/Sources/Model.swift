import Rakuten

final class MVVMModel {
    private let useCase = RakutenUseCase.instance()

    func search() async -> [RakutenItem] {
        let model = try? await useCase.search(
            keyword: "からあげ",
            page: 1
        )
        return model?.items ?? []
    }
}
