//
//  ContentViewCore.swift
//  Booer
//
//  Created by Veit Progl on 14.06.22.
//

import ComposableArchitecture
import BooerCalendar
import BookManagment

public enum AppCore {}

public extension AppCore {
    enum Action: Equatable {
        case calendar(CalendarAction)
        case addBook(AddBookCore.Action)
        case bookOverview(BookOverviewCore.Action)
    }
    
    struct State: Equatable {
        var activeDate: Date
//        var navigation: [Route]

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
    
    struct Environment {}
    
    static let reducer = Reducer<State, Action, Environment>.combine(
        calendarReducer.pullback(state: \.calendar,
                                 action: /Action.calendar,
                                 environment: { _ in CalendarEnvironment() }),
        AddBookCore.reducer.pullback(state: \.addBookState,
                                     action: /Action.addBook,
                                     environment: { _ in AddBookCore.Environment.dev }),
        BookOverviewCore.reducer.pullback(state: \.bookOverviewState, action: /Action.bookOverview, environment: {_ in BookOverviewCore.Environment()}),
        .init { state, action, environment in
            switch action {
            default:
                return .none
            }
        }
    )

}

