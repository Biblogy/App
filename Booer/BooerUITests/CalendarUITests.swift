//
//  CalendarUITests.swift
//  BooerUITests
//
//  Created by Veit Progl on 28.09.22.
//

import XCTest

final class CalendarUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testOpenCalendar() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        app.collectionViews/*@START_MENU_TOKEN@*/.images["Calendar"]/*[[".cells.images[\"Calendar\"]",".images[\"Calendar\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["Calendar"]/*@START_MENU_TOKEN@*/.buttons["close"]/*[[".otherElements[\"close\"].buttons[\"close\"]",".buttons[\"close\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
   
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testChangeDay() throws {
        let app = XCUIApplication()
        app.launch()

        app.collectionViews/*@START_MENU_TOKEN@*/.images["Calendar"]/*[[".cells.images[\"Calendar\"]",".images[\"Calendar\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.scrollViews.children(matching: .other).element(boundBy: 0).children(matching: .other).element(boundBy: 1).tap()
    }
    
    func testChangeMonth() throws {
        let app = XCUIApplication()
        app.launch()

        app.collectionViews/*@START_MENU_TOKEN@*/.images["Calendar"]/*[[".cells.images[\"Calendar\"]",".images[\"Calendar\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.scrollViews.children(matching: .other).element(boundBy: 0).children(matching: .other).element(boundBy: 1).tap()
        
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery/*@START_MENU_TOKEN@*/.images["Calendar"]/*[[".cells.images[\"Calendar\"]",".images[\"Calendar\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let scrollViewsQuery = app.scrollViews
        scrollViewsQuery.otherElements.staticTexts["Oktober"].swipeUp()
        
        let element = scrollViewsQuery.children(matching: .other).element(boundBy: 0)
        element.swipeUp()
        element.children(matching: .other).element(boundBy: 1).staticTexts["16"].tap()
        collectionViewsQuery.children(matching: .cell).element(boundBy: 0).staticTexts["November"].tap()
        
    }

}
