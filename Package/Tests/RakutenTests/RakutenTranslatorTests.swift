@testable import Rakuten
import XCTest

final class RakutenTranslatorTests: XCTestCase {
    private var translator: RakutenTranlator!

    override func setUp() {
        super.setUp()

        translator = .init()
    }

    override func tearDown() {
        super.tearDown()

        translator = nil
    }

    func test_translate_from_rakutenEntity_to_rakutenModel() {
        // arrange
        let entity = RakutenEntity(
            items: [.init(
                itemName: "name1",
                catchcopy: "description1",
                itemCode: "itemCode1",
                itemPrice: 12345,
                itemCaption: "itemCaption1",
                itemUrl: "https://test.com",
                smallImageUrls: ["https://test.com/small"],
                mediumImageUrls: ["https://test.com/medium"]
            )],
            count: 1,
            page: 1,
            first: 1,
            last: 1,
            hits: 1,
            carrier: 1,
            pageCount: 1
        )

        // act
        let actual = translator.translate(entity)

        // assert
        XCTAssertEqual(
            actual.items.first?.name,
            "name1"
        )
    }
}
