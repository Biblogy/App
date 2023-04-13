//
//  ErrorHandlerTests.swift
//  
//
//  Created by Veit Progl on 10.04.23.
//

import XCTest
import SwiftUI
@testable import BooerKit

// Define a custom error to test with
enum CustomError: ErrorProtocol {
    case testError

    var code: Int {
        switch self {
        case .testError:
            return 999
        }
    }

    var title: String {
        switch self {
        case .testError:
            return "Test Error"
        }
    }

    var message: String {
        switch self {
        case .testError:
            return "This is a test error."
        }
    }
}

class ErrorHandlerTests: XCTestCase {
    var mockViewController: UIViewController!

    override func setUp() {
        super.setUp()
        mockViewController = UIViewController()
    }

    override func tearDown() {
        mockViewController = nil
        super.tearDown()
    }

    func testDefaultErrorCopy() {
        XCTAssertEqual(DefaultErrorCopy.title, "Error")
        XCTAssertEqual(DefaultErrorCopy.message, "An error has occurred. Please try again later, if this happens multiple times contact support")
    }

    func testErrorProtocol() {
        let error = CustomError.testError
        XCTAssertEqual(error.code, 999)
        XCTAssertEqual(error.title, "Test Error")
        XCTAssertEqual(error.message, "This is a test error.")
    }

}
