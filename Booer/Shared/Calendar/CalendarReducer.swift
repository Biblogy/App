//
//  CalendarReducer.swift
//  Booer (iOS)
//
//  Created by Veit Progl on 21.04.22.
//

import ComposableArchitecture


let calendarReducer = Reducer<CalendarState, CalendarAction, CalendarEnvironment> { state, action, environment in
    switch action {
    case .changeActiveDate(let date):
        state.activeDate = date
        state.weekDays = state.weekdays(from: date)
        state.month = date.getMonthString()
        return .none
        
    case .weekdays(let dateInWeek):
        let dayOfWeek = state.calendar.component(.weekday, from: dateInWeek)
        let weekdays = state.calendar.range(of: .weekday, in: .weekOfYear, for: dateInWeek)!
        let days = (weekdays.lowerBound ..< weekdays.upperBound).map { day -> CalendarDate in
            let day = state.calendar.date(byAdding: .day, value: day - dayOfWeek, to: dateInWeek)!
            let today = day.getToday()
            return CalendarDate(date: day, today: today)
        }
        
        state.weekDays = days
        return .none
    case .getMonth(let date):
        state.month = date.getMonthString()
        return .none
        
    case .getMonthList:
        state.monthList = state.getMonths()
        return .none
        
    case .getDay(let date):
        
        return .none
    }
  }
