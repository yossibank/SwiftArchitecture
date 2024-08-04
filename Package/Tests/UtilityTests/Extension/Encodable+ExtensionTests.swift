@testable import Utility
import XCTest

final class EncodableTests: XCTestCase {
    func test_dictionary() {
        // arrange
        struct Parameters: Encodable {
            let userId: Int
            let userName: String
        }

        let parameters = Parameters(userId: 1, userName: "test1")

        // act
        let dictionary = parameters.dictionary

        // assert
        XCTAssertEqual(dictionary["userId"] as! Int, 1)
        XCTAssertEqual(dictionary["userName"] as! String, "test1")
    }
}
