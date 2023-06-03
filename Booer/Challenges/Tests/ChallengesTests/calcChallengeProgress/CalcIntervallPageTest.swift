//
//  File.swift
//
//
//  Created by Veit Progl on 25.03.23.
//

import Foundation
import BooerKit
import XCTest
@testable import Challenges

final class CalcIntervallPageTest: XCTestCase {
    let sut = CalcIntervallPage()
    var book = Book(id: "1", title: "test", cover: URL(string: "https://veit.pro")!, author: [], pages: 300)
    
    func testIsFailed_Time() throws {
        it("should return true") {
            let progress = self.createMock(progress: ["2022-8-20", "2022-9-20", "2022-10-20"])
            let start = self.createMock(date: "2022-8-19")
            let end = self.createMock(date: "2022-10-21")
            let result   = sut.isFailed(pages: 20,
                                        intervall: .month,
                                        progressData: progress,
                                        start: start,
                                        end: end,
                                        book: book)
            
            XCTAssert(result == ProgressState.success)
        }
        
        it("should return false") {
            let progress = self.createMock(progress: ["2022-8-20", "2022-10-20"])
            let start = self.createMock(date: "2022-8-19")
            let end = self.createMock(date: "2022-10-21")
            let result   = sut.isFailed(pages: 20,
                                        intervall: .month,
                                        progressData: progress,
                                        start: start,
                                        end: end,
                                        book: book)

            XCTAssert(result == ProgressState.failed)
        }

        it("should return true") {
            let progress = self.createMock(progress: ["2022-8-20", "2022-9-20",])
            let start = self.createMock(date: "2022-8-19")
            let end = self.createMock(date: "2022-10-21")
            let result   = sut.isFailed(pages: 20,
                                        intervall: .month,
                                        progressData: progress,
                                        start: start,
                                        end: end,
                                        book: book)

            XCTAssert(result == ProgressState.progress(66))
        }

        it("should return true") {
            let progress = self.createMock(progress: ["2022-8-20", "2022-8-22", "2022-9-20"])
            let start = self.createMock(date: "2022-8-19")
            let end = self.createMock(date: "2022-10-21")
            let result   = sut.isFailed(pages: 20,
                                        intervall: .month,
                                        progressData: progress,
                                        start: start,
                                        end: end,
                                        book: book)

            XCTAssert(result == ProgressState.progress(66))
        }
        
        it("should return success") {
            let progress = self.createMock(progress: ["2022-9-21"])
            let start = self.createMock(date: "2022-9-21")
            let end = self.createMock(date: "2022-9-21")
            let result   = sut.isFailed(pages: 20,
                                        intervall: .month,
                                        progressData: progress,
                                        start: start,
                                        end: end,
                                        book: book)

            XCTAssert(result == ProgressState.success)
        }
        
        it("should return failed") {
            let progress = self.createMock(progress: ["2022-9-21"])
            let start = self.createMock(date: "2022-9-21")
            let end = self.createMock(date: "2022-8-19")
            let result   = sut.isFailed(pages: 20,
                                        intervall: .month,
                                        progressData: progress,
                                        start: start,
                                        end: end,
                                        book: book)

            XCTAssert(result == ProgressState.failed)
        }
    }
    
    func testIsFailed_inputDates() throws {
        it("should not fail if too early progress") {
            let progress = self.createMock(progress: ["2022-6-21", "2022-7-21", "2022-8-21", "2022-9-21"], maxPages: 900)
            let start = self.createMock(date: "2022-8-21")
            let end = self.createMock(date: "2022-10-19")
            let result   = sut.isFailed(pages: 20,
                                        intervall: .month,
                                        progressData: progress,
                                        start: start,
                                        end: end,
                                        book: book)

            XCTAssert(result == ProgressState.progress(66))
        }
    }
    
    func testIsFailed_Pages() throws {
        it("should return true, if book is finished early") {
            book = Book(id: "1", title: "test", cover: URL(string: "https://veit.pro")!, author: [], pages: 100)

            let progress = self.createMock(progress: ["2022-8-20", "2022-8-22", "2022-8-23", "2022-9-20"], maxPages: 100)
            let start = self.createMock(date: "2022-8-19")
            let end = self.createMock(date: "2022-10-21")
            let result   = sut.isFailed(pages: 25,
                                        intervall: .month,
                                        progressData: progress,
                                        start: start,
                                        end: end,
                                        book: book)

            XCTAssert(result == ProgressState.progress(66))
        }
        
        it("should return false, if book is not egouth pages per day") {
            book = Book(id: "1", title: "test", cover: URL(string: "https://veit.pro")!, author: [], pages: 100)

            let progress = self.createMock(progress: ["2022-8-20", "2022-8-22", "2022-8-23", "2022-9-20"], maxPages: 100)
            let start = self.createMock(date: "2022-8-19")
            let end = self.createMock(date: "2022-10-21")
            let result   = sut.isFailed(pages: 30,
                                        intervall: .month,
                                        progressData: progress,
                                        start: start,
                                        end: end,
                                        book: book)

            XCTAssert(result == ProgressState.failed)
        }
        
        
    }
    
    //MARK: Day Challenges
    
    func testCalcPagesPerDay() throws {
        book = Book(id: "2",
                    title: "test",
                    cover: URL(string: "https://veit.pro")!,
                    author: [],
                    pages: 100)

        let progress = self.createMock(progress: ["2022-8-23", "2022-8-24", "2022-8-25", "2022-9-20"], maxPages: 4)

        let start = self.createMock(date: "2022-8-19")
        let end = self.createMock(date: "2022-8-21")
        let result = sut.isFailed(pages: 2,
                                  intervall: .day,
                                  progressData: progress,
                                  start: start,
                                  end: end,
                                  book: book)

        XCTAssert(result == ProgressState.failed)
    }
        
    func testCalcPagesPerDay_empty_input_endDate() throws {
        book = Book(id: "2",
                    title: "test",
                    cover: URL(string: "https://veit.pro")!,
                    author: [],
                    pages: 100)

        let start = self.createMock(date: "2022-8-19")
        let end = self.createMock(date: "2022-8-21")
        let result = sut.isFailed(pages: 2,
                                  intervall: .day,
                                  progressData: [],
                                  start: start,
                                  end: end,
                                  book: book)

        XCTAssert(result == ProgressState.failed)
    }
    
    func testcalcPageChanges() throws {
        let progress = self.createMock(progress: ["2022-8-20", "2022-8-22", "2022-8-23", "2022-9-20"], maxPages: 100)

        let result = sut.calcPageChanges(progressData: progress)
        XCTAssert(result == [25, 25, 25, 25])
    }
    
    func createMock(progress dateStrings: [String], maxPages: Int = 200) -> [ProgressData] {
        var dates: [ProgressData] = []
        
        let pagesPerStep = maxPages / dateStrings.count
        var pages = 0
        
        dateStrings.forEach {date in
            pages += pagesPerStep
            dates.append(ProgressData(date: self.createMock(date: date),
                                      currentPage: pages,
                                      id: UUID().uuidString))
        }
        
        return dates
    }
    
    func createMock(date: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd"
        let date = dateFormatter.date(from: date)
        return date!
    }
}
