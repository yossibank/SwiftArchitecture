import Combine

final class FluxDispatcher {
    static let shared = FluxDispatcher()

    private var cancellables = [AnyCancellable]()

    private let actionSubject = PassthroughSubject<FluxAction, Never>()

    private init() {}

    func register(callback: @escaping (FluxAction) -> Void) {
        let actionStream = actionSubject.sink(receiveValue: callback)
        cancellables += [actionStream]
    }

    func dispatch(_ action: FluxAction) {
        actionSubject.send(action)
    }
}
