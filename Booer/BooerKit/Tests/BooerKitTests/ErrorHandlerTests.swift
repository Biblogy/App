//
//  ErrorHandlerTests.swift
//  
//
//  Created by Veit Progl on 10.04.23.
//

import XCTest
@testable import BooerKit

class ErrorHandlerTests: XCTestCase {
    
    // Testet, ob showError() der ErrorHandler-Klasse ein Alert-Fenster anzeigt
    func testShowErrorDisplaysAlert() {
        let error = TestError()
        let handler = ErrorHandler()
        
        DispatchQueue.main.async {
            ErrorHandler.showError(error)
        }

        let expectation = self.expectation(for: NSPredicate(format: "count > 0"), evaluatedWith: XCUIApplication().windows, handler: nil)
        wait(for: [expectation], timeout: 1)
        
        let alertExists = XCUIApplication().alerts.element.exists
        XCTAssertTrue(alertExists)
    }
    
    // Testet, ob showError() der ErrorHandler-Klasse die richtige Fehlermeldung anzeigt
    func testShowErrorDisplaysCorrectMessage() {
        let error = TestError()
        let handler = ErrorHandler()
        
        DispatchQueue.main.async {
            ErrorHandler.showError(error)
        }
        
        let alert = XCUIApplication().alerts.element
        let message = alert.staticTexts.element.label
        XCTAssertEqual(message, error.message + "error code: " + String(error.code))
    }
}

// Helper Klasse, um einen einfachen Mock-Error zu erstellen
class TestError: ErrorProtocol {
    var code: Int = 500
    var title: String = "Test Error"
    var message: String = "This is a test error message."
}
