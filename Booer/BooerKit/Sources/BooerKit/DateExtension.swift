//
//  DateWorker.swift
//  Booer (iOS)
//
//  Created by Veit Progl on 09.03.22.
//

import Foundation

public extension Date {
    func getToday() -> Bool {
        return Calendar.current.isDate(Date(), inSameDayAs: self)
    }
    
    func getDay() -> Int {
        let components = Calendar.current.dateComponents([.day], from: self)
        return components.day!
    }

    func getMonth() -> Int {
        let components = Calendar.current.dateComponents([.month], from: self)
        return components.month!
    }

    func removeTime() -> Date {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: self)
        return Calendar.current.date(from: components)!
    }
    
    func getMonthString() -> String {
        let month = Calendar.current.component(.month, from: self)
        let monthString = Calendar.current.monthSymbols[month - 1]
        return monthString
    }
    
    func getYear() -> Int {
        let components = Calendar.current.dateComponents([.year], from: self)
        return components.year!
    }
}
