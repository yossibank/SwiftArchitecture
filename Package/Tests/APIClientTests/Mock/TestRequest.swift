@testable import APIClient

struct TestRequest: APIRequest {
    typealias APIResponse = [TestObject]
    typealias PathComponent = EmptyPathComponent

    struct Parameters: Encodable {
        let userId: Int?
    }

    var baseURL: String { "https://test.com" }
    var path: String { "/user/list" }
    var method: HTTPMethod { .get }

    let parameters: Parameters

    init(
        parameters: Parameters,
        pathComponent: PathComponent = .init()
    ) {
        self.parameters = parameters
    }
}
