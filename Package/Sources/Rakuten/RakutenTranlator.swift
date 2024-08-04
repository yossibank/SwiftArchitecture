import Foundation
import Utility

/// @mockable
public protocol RakutenTranlatorProtocol {
    func translate(_ entity: RakutenEntity) -> RakutenModel
}

public struct RakutenTranlator: RakutenTranlatorProtocol {
    public init() {}

    public func translate(_ entity: RakutenEntity) -> RakutenModel {
        .init(
            items: entity.items.map {
                .init(
                    id: $0.itemCode,
                    name: $0.itemName,
                    description: $0.itemCaption,
                    price: GroupingComma.value($0.itemPrice),
                    imageURL: $0.mediumImageUrls.compactMap {
                        .init(string: $0)
                    }.first,
                    imageURLs: $0.mediumImageUrls.compactMap {
                        .init(string: $0)
                    },
                    itemURL: .init(string: $0.itemUrl)
                )
            },
            totalCount: entity.count,
            currentPage: entity.page,
            maxPage: entity.pageCount
        )
    }
}
