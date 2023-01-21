//
//  AppCore.swift
//  Booer
//
//  Created by Veit Progl on 11.07.22.
//
import ComposableArchitecture
import BooerCalendar
import BookManagment
import CasePaths
import Foundation
import Challenges

public enum AppCore {}

public extension AppCore {
    
    enum Action: Equatable {
        case calendar(CalendarCore.Action)
        case addBook(AddBookCore.Action)
        case bookOverview(BookOverviewCore.Action)
        case challengePage(ChallengePageCore.Action)
        case newChallenge(NewChallengePageCore.Action)
    }
    
    struct State: Equatable {
        var activeDate: Date

        public init() {
            self.activeDate = Date()
        }
                
        var calendar: CalendarCore.State {
            get { CalendarCore.State(activeDate: activeDate) }
            set { activeDate = newValue.activeDate }
        }
        
        var addBookState = AddBookCore.State()
        
        var bookOverviewState = BookOverviewCore.State()
        
        var challengePage = ChallengePageCore.State()
        
        var newChallenge = NewChallengePageCore.State()
    }
    
    struct Environment {}
    
    static let reducer = Reducer<State, Action, Environment>.combine(
        AnyReducer {environment in
            CalendarCore()
        }.pullback(state: \State.calendar, action: /Action.calendar, environment: {$0}),
        AddBookCore.reducer.pullback(state: \.addBookState,
                                     action: /Action.addBook,
                                     environment: { _ in AddBookCore.Environment.live }),
        BookOverviewCore.reducer.pullback(state: \.bookOverviewState, action: /Action.bookOverview, environment: {_ in BookOverviewCore.Environment()}),
        AnyReducer {environment in
            ChallengePageCore()
        }.pullback(state: \State.challengePage, action: /Action.challengePage, environment: {$0}),
        .init { state, action, environment in
            switch action {
            default:
                return .none
            }
        }
    )
}

