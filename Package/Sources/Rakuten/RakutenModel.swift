import Foundation

public struct RakutenModel: Hashable {
    public let items: [RakutenItem]
    public let totalCount: Int
    public let currentPage: Int
    public let maxPage: Int
}

public struct RakutenItem: Hashable {
    public let id: String
    public let name: String
    public let description: String
    public let price: String
    public let imageURL: URL?
    public let imageURLs: [URL]
    public let itemURL: URL?
}
