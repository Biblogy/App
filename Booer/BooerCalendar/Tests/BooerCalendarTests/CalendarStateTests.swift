//
//  CalendarStateTests.swift
//  
//
//  Created by Veit Progl on 23.04.22.
//

import XCTest
@testable import BooerCalendar

class ClendarStateTests: XCTestCase {
    let sut = CalendarState(activeDate: Date())
    
    func test_getMonths(){
        it("should return CalendarMonth array"){
            let result = sut.getMonths()
            XCTAssert(type(of: result) == [CalendarMonth].self)
        }
        
        it("should return 12 entrys"){
            let result = sut.getMonths()
            XCTAssert(result.count == 12)
        }
        
        it("shoud return Januar"){
            let result = sut.getMonths()
            XCTAssert(result.first!.date.getMonthString() == "Januar")
        }
        
        it("shoud return Dezember"){
            let result = sut.getMonths()
            XCTAssert(result.last!.date.getMonthString() == "Dezember")
        }
    }
    
    func test_weeddays(){
        it("return count shoud be 7") {
            let result = sut.weekdays()
            
            XCTAssert(result.count == 7)
        }
        
        it("return shoud include input date") {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd HH:mm"
            let someDateTime = formatter.date(from: "2021/02/27 13:42")
            
            let inputDate = Date(timeInterval: 0, since: someDateTime!)
            let result = sut.weekdays(from: inputDate)
            let resultDate = result.first(where: {$0.date == inputDate})
            XCTAssert(resultDate?.date == inputDate)
        }
        
        it("return shoud start with first weekday") {
            let result = sut.weekdays()
            let calendar = Calendar.current
            let weekday = calendar.component(.weekday, from: result.first!.date)
            
            XCTAssert(weekday == 1)
        }
        
        
        it("retun shoud end with last weekday") {
            let result = sut.weekdays()
            let calendar = Calendar.current
            let weekday = calendar.component(.weekday, from: result.last!.date)
            
            XCTAssert(weekday == 7)
        }
        
        it("shoud set today"){
            let result = sut.weekdays()
            
            XCTAssert(result.contains(where: {$0.isToday == true}))
        }
        
        it("isToday shoud only be one time true"){
            let result = sut.weekdays()
            let todays = result.filter({$0.isToday == true})
            XCTAssert(todays.count == 1)
        }
    }
    
    func test_generateDays(){
        it("shoud return CalendarDate array"){
            let result = sut.generateDays(for: Date())
            XCTAssert(type(of: result) == [CalendarDate].self)
        }
        
        it("shoud return array with first day of month in it"){
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd"
            let startDateTime = formatter.date(from: "2021/02/1")
            let startDate = Date(timeInterval: 0, since: startDateTime!)

            let result = sut.generateDays(for: startDate)
            XCTAssert(result.count == 35)
            XCTAssert(result.contains(where: { $0.date == startDate}))
        }
    }
    
    func test_generateMonth(){
        it("should return CalendarMonth array"){
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd HH:mm"
            let startDateTime = formatter.date(from: "2021/02/1 13:42")
            let startDate = Date(timeInterval: 0, since: startDateTime!)
            
            let endDateTime = formatter.date(from: "2021/02/20 13:42")
            let endDate = Date(timeInterval: 0, since: endDateTime!)
            
            let dateIntervall = DateInterval(start: startDate, end: endDate)
            let result = sut.generateMonths(interval: dateIntervall)
            XCTAssert(type(of: result) == [CalendarMonth].self)
        }
        
        it("should return array with cout of 1"){
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd HH:mm"
            let startDateTime = formatter.date(from: "2021/02/1 13:42")
            let startDate = Date(timeInterval: 0, since: startDateTime!)
            
            let endDateTime = formatter.date(from: "2021/02/20 13:42")
            let endDate = Date(timeInterval: 0, since: endDateTime!)
            
            let dateIntervall = DateInterval(start: startDate, end: endDate)
            let result = sut.generateMonths(interval: dateIntervall)
            XCTAssert(result.count == 1)
        }
        
        it("should return first of month"){
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd HH:mm"
            let startDateTime = formatter.date(from: "2021/02/1 13:42")
            let startDate = Date(timeInterval: 0, since: startDateTime!)
            
            let endDateTime = formatter.date(from: "2021/02/20 13:42")
            let endDate = Date(timeInterval: 0, since: endDateTime!)
            
            let dateIntervall = DateInterval(start: startDate, end: endDate)
            let result = sut.generateMonths(interval: dateIntervall)
            XCTAssert(result.first!.date == startDate)
        }
    }
}
