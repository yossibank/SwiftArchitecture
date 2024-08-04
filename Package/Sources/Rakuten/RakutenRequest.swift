import APIClient

// https://webservice.rakuten.co.jp/explorer/api/IchibaItem/Search
public struct RakutenRequest: APIRequest {
    public typealias APIResponse = RakutenEntity
    public typealias PathComponent = EmptyPathComponent

    public struct Parameters: Encodable {
        public let keyword: String
        public let page: Int
        public let hits: Int
        public let formatVersion: Int
        public let applicationId: String

        public init(
            keyword: String,
            page: Int = 1,
            hits: Int = 30,
            formatVersion: Int = 2,
            applicationId: String = "1032211485929725116"
        ) {
            self.keyword = keyword
            self.page = page
            self.hits = hits
            self.formatVersion = formatVersion
            self.applicationId = applicationId
        }
    }

    public var baseURL: String { "https://app.rakuten.co.jp" }
    public var path: String { "/services/api/IchibaItem/Search/20220601" }
    public var method: HTTPMethod { .get }

    public let parameters: Parameters

    public init(
        parameters: Parameters,
        pathComponent: PathComponent = .init()
    ) {
        self.parameters = parameters
    }
}
