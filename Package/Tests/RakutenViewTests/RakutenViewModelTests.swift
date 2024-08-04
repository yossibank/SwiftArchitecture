@testable import AppCore
@testable import Rakuten
@testable import RakutenView
import XCTest

final class RakutenViewModelTests: XCTestCase {
    private var useCase: RakutenUseCaseProtocolMock!
    private var viewModel: RakutenViewModel!

    override func setUp() async throws {
        try await super.setUp()

        useCase = .init()

        await viewModel = .init(
            state: .init(),
            dependency: .init(useCase: useCase)
        )
    }

    override func tearDown() async throws {
        try await super.tearDown()

        useCase = nil
        viewModel = nil
    }

    @MainActor
    func test_search_success() async {
        // arrange
        let loadedItems = [
            RakutenItem(
                id: "1",
                name: "title1",
                description: "description1",
                price: "1,000円",
                imageURL: nil,
                imageURLs: [],
                itemURL: nil
            )
        ]

        useCase.searchHandler = { _, _ in
            RakutenModel(
                items: loadedItems,
                totalCount: 100,
                currentPage: 1,
                maxPage: 10
            )
        }

        // act
        await viewModel.search()

        // assert
        XCTAssertEqual(
            viewModel.state.loadedItems,
            loadedItems
        )
        XCTAssertEqual(
            viewModel.state.viewState,
            .loaded(loaded: loadedItems)
        )
    }

    @MainActor
    func test_search_failure() async {
        // arrange
        let appError = AppError(apiError: .invalidStatusCode(400))

        useCase.searchHandler = { _, _ in
            throw appError
        }

        // act
        await viewModel.search()

        // assert
        XCTAssertEqual(
            viewModel.state.loadedItems.count,
            0
        )
        XCTAssertEqual(
            viewModel.state.viewState,
            .initialError(appError)
        )
    }
}
