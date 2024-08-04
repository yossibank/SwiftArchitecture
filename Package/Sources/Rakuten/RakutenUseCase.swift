import APIClient
import AppCore

/// @mockable
public protocol RakutenUseCaseProtocol {
    func search(
        keyword: String,
        page: Int
    ) async throws -> RakutenModel
}

public final class RakutenUseCase: RakutenUseCaseProtocol {
    private let apiClient: any APIClientProtocol
    private let translator: any RakutenTranlatorProtocol

    public init(
        apiClient: any APIClientProtocol,
        translator: any RakutenTranlatorProtocol
    ) {
        self.apiClient = apiClient
        self.translator = translator
    }

    public func search(
        keyword: String,
        page: Int
    ) async throws -> RakutenModel {
        do {
            let entity = try await apiClient.request(
                item: RakutenRequest(
                    parameters: .init(
                        keyword: keyword,
                        page: page
                    )
                )
            )
            return translator.translate(entity)
        } catch {
            throw AppError.parse(error)
        }
    }
}

public extension RakutenUseCase {
    static func instance() -> RakutenUseCase {
        .init(
            apiClient: APIClient(),
            translator: RakutenTranlator()
        )
    }
}
