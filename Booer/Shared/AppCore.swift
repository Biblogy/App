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

public struct AppCore: ReducerProtocol {
    
    public enum Action: Equatable {
        case calendar(CalendarCore.Action)
        case addBook(AddBookCore.Action)
        case bookOverview(BookOverviewCore.Action)
        case challengePage(ChallengePageCore.Action)
        case newChallenge(NewChallengePageCore.Action)
    }
    
    public struct State: Equatable {
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
    
    public var body: some ReducerProtocol<State, Action> {
        Scope(state: \State.calendar, action: /Action.calendar) {
            CalendarCore()
        }
        
        Scope(state: \State.addBookState, action: /Action.addBook) {
            AddBookCore()
        }
        
        Scope(state: \State.bookOverviewState, action: /Action.bookOverview) {
            BookOverviewCore()
        }
        
        Scope(state: \State.challengePage, action: /Action.challengePage) {
            ChallengePageCore()
        }
        
        Reduce { state, action in
            switch action {
            case .calendar(_):
                return .none
            case .addBook(_):
                return .none
            case .bookOverview(_):
                return .none
            case .challengePage(_):
                return .none
            case .newChallenge(_):
                return .none
            }
        }._printChanges()
    }
}

