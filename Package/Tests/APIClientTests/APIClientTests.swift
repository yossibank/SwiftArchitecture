@testable import APIClient
import OHHTTPStubs
import OHHTTPStubsSwift
import XCTest

final class APIClientTests: XCTestCase {
    private var apiClient: APIClient!

    override func setUp() {
        super.setUp()

        apiClient = .init()
    }

    override func tearDown() {
        super.tearDown()

        apiClient = nil

        HTTPStubs.removeAllStubs()
    }

    func test_success_response() async throws {
        // arrange
        stub(condition: isPath("/user/list")) { _ in
            fixture(
                filePath: OHPathForFileInBundle(
                    "success.json",
                    .module
                )!,
                headers: ["Content-Type": "application/json"]
            )
        }

        // act
        let response = try await apiClient.request(
            item: TestRequest(parameters: .init(userId: 1))
        )

        // assert
        XCTAssertEqual(response.count, 10)
        XCTAssertEqual(response.first?.userId, 1)
    }

    func test_failure_decode() async throws {
        // arrange
        stub(condition: isPath("/user/list")) { _ in
            fixture(
                filePath: OHPathForFileInBundle(
                    "failure.json",
                    .module
                )!,
                headers: ["Content-Type": "application/json"]
            )
        }

        do {
            // act
            _ = try await apiClient.request(
                item: TestRequest(parameters: .init(userId: nil))
            )
        } catch {
            // assert
            XCTAssertEqual(
                error as! APIError,
                .decodeError
            )
        }
    }

    func test_failure_timeout() async throws {
        // arrange
        stub(condition: isPath("/user/list")) { _ in
            let error = NSError(
                domain: NSURLErrorDomain,
                code: URLError.timedOut.rawValue
            )
            return HTTPStubsResponse(error: error)
        }

        do {
            // act
            _ = try await apiClient.request(
                item: TestRequest(parameters: .init(userId: nil))
            )
        } catch {
            // assert
            XCTAssertEqual(
                error as! APIError,
                .timeoutError
            )
        }
    }

    func test_failure_notConnectInternet() async throws {
        // arrange
        stub(condition: isPath("/user/list")) { _ in
            let error = NSError(
                domain: NSURLErrorDomain,
                code: URLError.notConnectedToInternet.rawValue
            )
            return HTTPStubsResponse(error: error)
        }

        do {
            // act
            _ = try await apiClient.request(
                item: TestRequest(parameters: .init(userId: nil))
            )
        } catch {
            // assert
            XCTAssertEqual(
                error as! APIError,
                .notConnectInternet
            )
        }
    }

    func test_failure_invalid_status() async throws {
        // arrange
        stub(condition: isPath("/user/list")) { _ in
            fixture(
                filePath: OHPathForFileInBundle(
                    "success.json",
                    .module
                )!,
                status: 500,
                headers: ["Content-Type": "application/json"]
            )
        }

        do {
            // act
            _ = try await apiClient.request(
                item: TestRequest(parameters: .init(userId: nil))
            )
        } catch {
            // assert
            XCTAssertEqual(
                error as! APIError,
                .invalidStatusCode(500)
            )
        }
    }

    func test_failure_unknown() async throws {
        // arrange
        stub(condition: isPath("/user/list")) { _ in
            let error = NSError(
                domain: NSURLErrorDomain,
                code: URLError.unknown.rawValue
            )
            return HTTPStubsResponse(error: error)
        }

        do {
            // act
            _ = try await apiClient.request(
                item: TestRequest(parameters: .init(userId: nil))
            )
        } catch {
            // assert
            XCTAssertEqual(
                error as! APIError,
                .unknown
            )
        }
    }
}
