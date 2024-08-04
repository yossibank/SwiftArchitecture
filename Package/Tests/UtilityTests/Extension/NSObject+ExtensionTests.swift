@testable import Utility
import XCTest

final class NSObjectExtensionTest: XCTestCase {
    func test_className_static() {
        // arrange
        class Test: NSObject {}

        let expected = "Test"

        // act
        let value = Test.className

        // assert
        XCTAssertEqual(
            value,
            expected
        )
    }

    func test_className() {
        // arrange
        class Test: NSObject {}

        let expected = "Test"

        // act
        let value = Test().className

        // assert
        XCTAssertEqual(
            value,
            expected
        )
    }
}
