@testable import Utility
import XCTest

final class GroupingCommaTests: XCTestCase {
    func test_value_int() {
        // arrange
        let value = 12345

        // act
        let actual = GroupingComma.value(value)

        // assert
        XCTAssertEqual(
            actual,
            "12,345円"
        )
    }

    func test_value_double() {
        // arrange
        let value: Double = 12345

        // act
        let actual = GroupingComma.value(value)

        // assert
        XCTAssertEqual(
            actual,
            "12,345円"
        )
    }

    func test_value_none() {
        // arrange
        let value = "12345"

        // act
        let actual = GroupingComma.value(value)

        // assert
        XCTAssertEqual(
            actual,
            "---円"
        )
    }
}
