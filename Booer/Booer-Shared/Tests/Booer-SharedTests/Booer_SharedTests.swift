import XCTest
@testable import Booer_Shared

final class Booer_SharedTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Booer_Shared().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
