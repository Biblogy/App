//
//  NewChallengePageCore.swift
//  
//
//  Created Veit Progl on 03.11.22.
//  Copyright © 2022. All rights reserved.
//

import ComposableArchitecture
import Foundation

public enum NewChallengePageCore {}

public extension NewChallengePageCore {
    struct State: Equatable {
        var selectedBookId: String?
        
        public init() {}
        //var selectBook = BooksListCore.State()
        var selectBook: BooksListCore.State {
            get { BooksListCore.State(id: selectedBookId) }
            set { selectedBookId = newValue.selectedBookId }
        }
        var selectType = TypeListCore.State()
    }

    enum Action: Equatable {
        case onAppear
        case selectBook(BooksListCore.Action)
        case selectType(TypeListCore.Action)
    }

    struct Environment {
        public init() {}
    }

    static let reducer = Reducer<State, Action, Environment>.combine(
        BooksListCore.reducer.pullback(state: \State.selectBook, action: /Action.selectBook, environment: { _ in BooksListCore.Environment() }),
        TypeListCore.reducer.pullback(state: \State.selectType, action: /Action.selectType, environment: { _ in TypeListCore.Environment() }),
        .init { state, action, environment in
            return .none
        }
    )
}
