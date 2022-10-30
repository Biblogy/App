//
//  File.swift
//  
//
//  Created by Veit Progl on 28.10.22.
//

import Foundation

protocol DateKitProtocol {
    func today() -> Date
}

class DateKit: DateKitProtocol {
    var mock: Date?
    var date: Date
    
    init() {
        self.date = Date()
    }
    init(mock: Date) {
        self.mock = mock
        self.date = Date()
    }
    
    func today() -> Date {
        if mock != nil {
            return mock!
        }
        return Date()
    }
    
    func checkToday() -> Bool {
        return Calendar.current.isDate(Date(), inSameDayAs: date)
    }
    
    func getMonthString() -> String {
        let month = Calendar.current.component(.month, from: date)
        let monthString = Calendar.current.monthSymbols[month - 1]
        return monthString
    }
}
