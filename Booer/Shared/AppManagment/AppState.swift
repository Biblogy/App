//
//  AppState.swift
//  Booer (iOS)
//
//  Created by Veit Progl on 21.04.22.
//

import ComposableArchitecture
import Booer_Calendar

struct AppState: Equatable {
    var calendar: CalendarState
        
    public init() {
        self.calendar = CalendarState()
    }
        
}
