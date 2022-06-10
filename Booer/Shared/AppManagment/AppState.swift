//
//  AppState.swift
//  Booer (iOS)
//
//  Created by Veit Progl on 21.04.22.
//

import ComposableArchitecture
import BooerCalendar
import BookManagment

struct CallengeCompactState: Equatable {
    var activeDate: Date
    
    init(activeDate: Date){
        self.activeDate = activeDate
    }
}

struct AppState: Equatable {
    var activeDate: Date
    
    public init() {
        self.activeDate = Date()
    }
    
    var calendar: CalendarState {
        get { CalendarState(activeDate: activeDate) }
        set { activeDate = newValue.activeDate }
    }
    
    var addBookState = AddBookCore.State()
    
    var bookOverviewState = BookOverviewCore.State()
}
