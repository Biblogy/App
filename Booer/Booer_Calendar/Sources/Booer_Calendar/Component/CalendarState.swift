//
//  CalendarState.swift
//  Booer (iOS)
//
//  Created by Veit Progl on 21.04.22.
//

import ComposableArchitecture

public struct CalendarState: Equatable {
    var weekDays: [CalendarDate] = []
    var month: String = ""
    var monthList: [CalendarMonth] = []
    public internal(set) var activeDate: Date = Date()
    let calendar = Calendar.current

    public init(activeDate: Date = Date()){
        self.activeDate = activeDate
        self.weekDays = weekdays(from: activeDate)
        self.month = activeDate.getMonthString()
//        self.monthList = getMonths()
    }
}

extension CalendarState {
//    func getMonths() -> [CalendarMonth] {
//        var monthsList: [CalendarMonth] = []
//        while monthsList.count < 12 {
//            guard let monthInterval = calendar.dateInterval(of: .month, for: createFirstDay(month: monthsList.count + 1)) else {
//                return monthsList
//            }
//            let month = self.generateMonths(interval: monthInterval)
//            monthsList.append(month.first!)
//        }
//        return monthsList
//    }
    
    func weekdays(from dateInWeek: Date = Date()) -> [CalendarDate] {
        let dayOfWeek = calendar.component(.weekday, from: dateInWeek)
        let weekdays = calendar.range(of: .weekday, in: .weekOfYear, for: dateInWeek)!
        let days = (weekdays.lowerBound ..< weekdays.upperBound).map {
            createCalenderDate(day: $0, dayOfWeek: dayOfWeek, dateInWeek: dateInWeek)
        }
        
        return days
    }
    
    func createFirstDay(month: Int) -> Date {
        let year = calendar.component(.year, from: Date())
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        let someDateTime = formatter.date(from: "\(year)/\(month)/01 13:42")
        
        let date = Date(timeInterval: 0, since: someDateTime!)
        return date
    }
    
    private func createCalenderDate(day forDate: Int, dayOfWeek: Int, dateInWeek: Date) -> CalendarDate {
        let day = calendar.date(byAdding: .day, value: forDate - dayOfWeek, to: dateInWeek)!
        return CalendarDate(date: day)
    }
}


extension CalendarState {
    private func generateDates(
        inside interval: DateInterval,
        matching components: DateComponents
    ) -> [CalendarDate] {
        var dates: [CalendarDate] = []
        dates.append(.init(date: interval.start))

        Calendar.current.enumerateDates(
            startingAfter: interval.start,
            matching: components,
            matchingPolicy: .nextTime
        ) { date, _, stop in
            if let date = date {
                if date < interval.end {
                    dates.append(.init(date: date))
                } else {
                    stop = true
                }
            }
        }

        return dates
    }
    
    func generateDays(for month: Date) -> [CalendarDate] {
        guard
            let monthInterval = Calendar.current.dateInterval(of: .month, for: month),
            let monthFirstWeek = Calendar.current.dateInterval(of: .weekOfMonth, for: monthInterval.start),
            let monthLastWeek = Calendar.current.dateInterval(of: .weekOfMonth, for: monthInterval.end)
        else { return [] }
        return self.generateDates(
            inside: DateInterval(start: monthFirstWeek.start, end: monthLastWeek.end),
            matching: DateComponents(hour: 0, minute: 0, second: 0)
        )
    }
    
    func generateMonths(interval: DateInterval) -> [CalendarMonth] {
        return self.generateDates(
            inside: interval,
            matching: DateComponents(day: 1, hour: 0, minute: 0, second: 0)
        ).map { month in
            return CalendarMonth(date: month.date, days: self.generateDays(for: month.date))
        }
    }
}
