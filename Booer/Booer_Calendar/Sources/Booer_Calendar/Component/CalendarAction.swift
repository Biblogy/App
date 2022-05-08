//
//  CalendarAction.swift
//  Booer (iOS)
//
//  Created by Veit Progl on 21.04.22.
//

import Foundation

public enum CalendarAction: Equatable {
    case changeActiveDate(Date)
    case weekdays(Date)
    case getMonth(Date)
    case getMonthList
    case getDay(Date)
}
