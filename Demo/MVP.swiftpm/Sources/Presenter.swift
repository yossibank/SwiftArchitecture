import Foundation
import Rakuten

@Observable
final class MVPPresenter {
    private(set) var items = [RakutenItem]()

    private let model = MVPModel()

    func search() async {
        items = await model.search()
    }
}
