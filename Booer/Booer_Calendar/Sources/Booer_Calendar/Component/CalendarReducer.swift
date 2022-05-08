//
//  CalendarReducer.swift
//  Booer (iOS)
//
//  Created by Veit Progl on 21.04.22.
//

import ComposableArchitecture
import Combine

public let calendarReducer = Reducer<CalendarState, CalendarAction, CalendarEnvironment> { state, action, environment in
    switch action {
    case .changeActiveDate(let date):
        state.activeDate = date
        state.month = date.getMonthString()
        return .run({ subscriber  in
            subscriber.send(.weekdays(date)) as! Cancellable
        })
        
    case .weekdays(let dateInWeek):
        return .run({ subscriber  in
            let calender = Calendar.current
            let dayOfWeek = calender.component(.weekday, from: dateInWeek)
            let weekdays = calender.range(of: .weekday, in: .weekOfYear, for: dateInWeek)!
            let days = (weekdays.lowerBound ..< weekdays.upperBound).map { day -> CalendarDate in
                let day = calender.date(byAdding: .day, value: day - dayOfWeek, to: dateInWeek)!
                return CalendarDate(date: day)
            }
            
            return subscriber.send(.loadedWeekdays(days)) as! Cancellable
        })
    case .getMonth(let date):
        state.month = date.getMonthString()
        return .none
        
    case .getMonthList:
        var monthsList: [CalendarMonth] = []
        while monthsList.count < 12 {
            guard let monthInterval = Calendar.current.dateInterval(of: .month, for: state.createFirstDay(month: monthsList.count + 1)) else {
                return .none
            }
            let month = state.generateMonths(interval: monthInterval)
            monthsList.append(month.first!)
        }
        state.monthList = monthsList
        return .none
        
    case .getDay(let date):
        
        return .none
    case .loadedWeekdays(let weekdays):
        state.weekDays = weekdays
        return .none
    }
}

