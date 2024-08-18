import Combine
import Foundation
import Rakuten

@Observable
final class FluxStore {
    private(set) var items = [RakutenItem]()

    static let shared = FluxStore()

    private init(dispatcher: FluxDispatcher = .shared) {
        dispatcher.register { [weak self] action in
            guard let self else {
                return
            }

            switch action {
            case let .search(response):
                self.items = response
            }
        }
    }
}
