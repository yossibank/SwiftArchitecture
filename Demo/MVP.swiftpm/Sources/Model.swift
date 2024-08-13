import Rakuten

final class MVPModel {
    private let useCase = RakutenUseCase.instance()

    func search() async -> [RakutenItem] {
        let model = try? await useCase.search(
            keyword: "からあげ",
            page: 1
        )
        return model?.items ?? []
    }
}
