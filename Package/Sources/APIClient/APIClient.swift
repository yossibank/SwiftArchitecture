import AppDebug
import Foundation

/// @mockable
public protocol APIClientProtocol {
    func request<T>(item: some APIRequest<T>) async throws -> T
}

public struct APIClient: APIClientProtocol {
    public init() {}

    public func request<T>(item: some APIRequest<T>) async throws -> T {
        guard let urlRequest = createURLRequest(item) else {
            throw APIError.invalidRequest
        }

        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)

            guard let urlResponse = response as? HTTPURLResponse else {
                throw APIError.emptyResponse
            }

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            await DebugSwiftData.insert(
                .init(
                    data: data,
                    urlRequest: urlRequest,
                    urlResponse: urlResponse,
                    queryItems: item.queryItems
                )
            )

            return try JSONDecoder().decode(
                T.self,
                from: data
            )
        } catch {
            throw APIError.parse(error)
        }
    }
}

private extension APIClient {
    func createURLRequest(_ requestItem: some APIRequest) -> URLRequest? {
        guard let fullPath = URL(string: requestItem.baseURL + requestItem.path) else {
            return nil
        }

        var urlComponents = URLComponents()
        urlComponents.scheme = fullPath.scheme
        urlComponents.port = fullPath.port
        urlComponents.queryItems = requestItem.queryItems
        urlComponents.host = fullPath.host()
        urlComponents.path = fullPath.path()

        guard let url = urlComponents.url else {
            return nil
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.timeoutInterval = requestItem.timeoutInterval
        urlRequest.httpMethod = requestItem.method.rawValue
        urlRequest.httpBody = requestItem.body

        requestItem.headers.forEach {
            urlRequest.addValue($1, forHTTPHeaderField: $0)
        }

        return urlRequest
    }
}
