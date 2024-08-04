@testable import APIClient
@testable import Rakuten
import XCTest

final class RakutenUseCaseTests: XCTestCase {
    private var apiClient: APIClientProtocolMock!
    private var translator: RakutenTranlatorProtocolMock!
    private var useCase: RakutenUseCase!

    override func setUp() {
        super.setUp()

        apiClient = .init()
        translator = .init()
        useCase = .init(
            apiClient: apiClient,
            translator: translator
        )
    }

    override func tearDown() {
        super.tearDown()

        apiClient = nil
        translator = nil
        useCase = nil
    }

    func test_search() async throws {
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

        let model = RakutenModel(
            items: [
                .init(
                    id: "itemCode1",
                    name: "name1",
                    description: "description1",
                    price: "12,345円",
                    imageURL: .init(string: "https://test.com/medium"),
                    imageURLs: [],
                    itemURL: .init(string: "https://test.com")
                )
            ],
            totalCount: 1,
            currentPage: 1,
            maxPage: 1
        )

        apiClient.requestHandler = { request in
            XCTAssertTrue(request is RakutenRequest)
            return entity
        }

        translator.translateHandler = { _ in
            model
        }

        // act
        let actual = try await useCase.search(
            keyword: "keyword",
            page: 1
        )

        // assert
        XCTAssertEqual(
            actual,
            model
        )
    }
}
