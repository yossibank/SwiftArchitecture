import Foundation

public enum APIError: Error, Equatable {
    case decodeError
    case timeoutError
    case notConnectInternet
    case emptyData
    case emptyResponse
    case invalidRequest
    case invalidStatusCode(Int)
    case unknown
}

public extension APIError {
    static func parse(_ error: any Error) -> APIError {
        if error is DecodingError {
            return .decodeError
        }

        // -1001エラー
        // https://developer.apple.com/documentation/foundation/1508628-url_loading_system_error_codes/nsurlerrortimedout
        if error._code == NSURLErrorTimedOut {
            return .timeoutError
        }

        // -1009エラー
        // https://developer.apple.com/documentation/foundation/1508628-url_loading_system_error_codes/nsurlerrornotconnectedtointernet
        if error._code == NSURLErrorNotConnectedToInternet {
            return .notConnectInternet
        }

        guard let apiError = error as? APIError else {
            return .unknown
        }

        return apiError
    }
}
