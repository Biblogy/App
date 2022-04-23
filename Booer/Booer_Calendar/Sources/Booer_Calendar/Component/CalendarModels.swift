//
//  Models.swift
//  Booer (iOS)
//
//  Created by Veit Progl on 23.04.22.
//

import Foundation

public struct CalendarDate: Identifiable, Equatable {
    public var date: Date
    public var id = UUID().uuidString
    public var isToday: Bool
    public var active: Bool
    public var dateString: String
    
    public init(date: Date, today: Bool) {
        self.date = date
        self.isToday = today
        self.active = false
        
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: date)
        self.dateString = String(dateComponents.day!)
    }
}

public struct CalendarMonth: Identifiable, Equatable {
    public var date: Date
    public var id = UUID().uuidString
    public var days: [CalendarDate]
    
    public init(date: Date, days: [CalendarDate]) {
        self.date = date
        self.days = days
        
    }
}
