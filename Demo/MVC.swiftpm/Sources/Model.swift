import Foundation
import Rakuten

@Observable
final class MVCModel {
    private(set) var items = [RakutenItem]()

    private let useCase = RakutenUseCase.instance()

    func search() async {
        do {
            let model = try await useCase.search(keyword: "からあげ", page: 1)
            items = model.items
        } catch {
            print(error.localizedDescription)
        }
    }
}
