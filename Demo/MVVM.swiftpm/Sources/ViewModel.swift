import Foundation
import Rakuten

@Observable
final class MVVMViewModel {
    private(set) var items = [RakutenItem]()

    private let model = MVVMModel()

    func search() async {
        items = await model.search()
    }
}
