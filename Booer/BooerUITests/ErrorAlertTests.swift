//
//  ErrorAlertTests.swift
//  BooerUITests
//
//  Created by Veit Progl on 12.04.23.
//

import XCTest
// TestApp.swift
//import SwiftUI
//@testable import BooerKit
//
//enum CustomError: ErrorProtocol {
//    case testError
//
//    var code: Int {
//        switch self {
//        case .testError:
//            return 999
//        }
//    }
//
//    var title: String {
//        switch self {
//        case .testError:
//            return "Test Error"
//        }
//    }
//
//    var message: String {
//        switch self {
//        case .testError:
//            return "This is a test error."
//        }
//    }
//}
//
//
//struct TestApp: App {
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//        }
//    }
//}
//
//struct ContentView: View {
//    var body: some View {
//        VStack {
//            Button(action: {
//                let error = CustomError.testError
//                ErrorHandler.showError(error)
//            }) {
//                Text("Show Error")
//            }
//            Spacer()
//        }
//    }
//}
//
//final class ErrorAlertTests: XCTestCase {
//    var app: XCUIApplication!
//
//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//
//        // In UI tests it is usually best to stop immediately when a failure occurs.
//        continueAfterFailure = false
//
//        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
//        app = XCUIApplication()
//        app.launch()
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    func testShowErrorAlert() {
//
//        let showErrorButton = app.buttons["Show Error"]
//        XCTAssertTrue(showErrorButton.exists, "The Show Error button should exist.")
//        showErrorButton.tap()
//
//        let errorAlert = app.alerts["Error"]
//        let existsPredicate = NSPredicate(format: "exists == true")
//        expectation(for: existsPredicate, evaluatedWith: errorAlert, handler: nil)
//
//        let errorMessage = "An error has occurred. Please try again later, if this happens multiple times contact support error code: 1"
//        XCTAssertTrue(errorAlert.staticTexts[errorMessage].exists, "The error message should be displayed.")
//
//        errorAlert.buttons["OK"].tap()
//
//        waitForExpectations(timeout: 5, handler: nil)
//    }
//}
