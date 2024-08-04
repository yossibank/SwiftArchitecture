import Foundation
import Utility

public protocol APIRequest<APIResponse> {
    associatedtype Parameters: Encodable
    associatedtype APIResponse: Codable
    associatedtype PathComponent

    // necessary
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: Parameters { get }

    // option
    var timeoutInterval: TimeInterval { get }
    var body: Data? { get }
    var headers: [String: String] { get }
    var queryItems: [URLQueryItem]? { get }

    // initializer
    init(
        parameters: Parameters,
        pathComponent: PathComponent
    )
}

public extension APIRequest {
    var timeoutInterval: TimeInterval {
        10.0
    }

    var body: Data? {
        method == .get ? nil : try? JSONEncoder().encode(parameters)
    }

    var headers: [String: String] {
        var dic: [String: String] = [:]

        for item in APIRequestHeader.allCases {
            dic[item.rawValue] = item.value
        }

        return dic
    }

    var queryItems: [URLQueryItem]? {
        let query: [URLQueryItem] = if let p = parameters as? [any Encodable] {
            p.flatMap { param in
                param.dictionary.map {
                    .init(
                        name: $0.key,
                        value: String(describing: $0.value ?? "")
                    )
                }
            }
        } else {
            parameters.dictionary.map {
                .init(
                    name: $0.key,
                    value: String(describing: $0.value ?? "")
                )
            }
        }

        let queryItems = query.sorted { first, second in
            first.name < second.name
        }

        return method == .get ? queryItems : nil
    }
}

public extension APIRequest where Parameters == EmptyParameters {
    init(pathComponent: PathComponent) {
        self.init(
            parameters: .init(),
            pathComponent: pathComponent
        )
    }
}

public extension APIRequest where PathComponent == EmptyPathComponent {
    init(parameters: Parameters) {
        self.init(
            parameters: parameters,
            pathComponent: .init()
        )
    }
}
