import XCTest
@testable import Booer_iOS

final class Booer_iOSTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Booer_iOS().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
