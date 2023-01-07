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
        case calendar(CalendarAction)
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
                
        var calendar: CalendarState {
            get { CalendarState(activeDate: activeDate) }
            set { activeDate = newValue.activeDate }
        }
        
        var addBookState = AddBookCore.State()
        
        var bookOverviewState = BookOverviewCore.State()
        
        var challengePage = ChallengePageCore.State()
        
        var newChallenge = NewChallengePageCore.State()
    }
    
    struct Environment {}
    
    static let reducer = Reducer<State, Action, Environment>.combine(
        calendarReducer.pullback(state: \.calendar,
                                 action: /Action.calendar,
                                 environment: { _ in CalendarEnvironment() }),
        AddBookCore.reducer.pullback(state: \.addBookState,
                                     action: /Action.addBook,
                                     environment: { _ in AddBookCore.Environment.live }),
        BookOverviewCore.reducer.pullback(state: \.bookOverviewState, action: /Action.bookOverview, environment: {_ in BookOverviewCore.Environment()}),
        ChallengePageCore.reducer.pullback(state: \State.challengePage, action: /Action.challengePage, environment: {_ in ChallengePageCore.Environment()}),
        NewChallengePageCore.reducer.pullback(state: \State.newChallenge, action: /Action.newChallenge, environment: {_ in NewChallengePageCore.Environment()}),
        .init { state, action, environment in
            switch action {
            default:
                return .none
            }
        }
    )
}

