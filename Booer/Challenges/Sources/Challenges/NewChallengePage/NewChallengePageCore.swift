//
//  NewChallengePageCore.swift
//  
//
//  Created Veit Progl on 03.11.22.
//  Copyright © 2022. All rights reserved.
//

import ComposableArchitecture

public enum NewChallengePageCore {}

public extension NewChallengePageCore {
    struct State: Equatable {
        public init() {}
        var selectBook = BooksListCore.State()
    }

    enum Action: Equatable {
        case onAppear
        case selectBook(BooksListCore.Action)
    }

    struct Environment {
        public init() {}
    }

    static let reducer = Reducer<State, Action, Environment>.combine(
        BooksListCore.reducer.pullback(state: \.selectBook, action: /Action.selectBook, environment: { _ in BooksListCore.Environment() }),
        .init { state, action, environment in
            return .none
        }
    )
}
