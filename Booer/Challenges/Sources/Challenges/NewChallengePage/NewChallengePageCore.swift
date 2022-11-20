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
        public var books: [Book] = []
        public var selectedBookId: String?
    }

    enum Action: Equatable {
        case onAppear
        case changeBook(String?)
    }

    struct Environment {
        public init() {}
    }

    static let reducer = Reducer<State, Action, Environment>.combine(
        .init { state, action, environment in
            switch action {
            case .onAppear:
                state.books = DatabaseConnect().getAllBooks()
                return .none
            case .changeBook(let bookId):
                state.selectedBookId = bookId ?? nil
                return .none
            }
        }
    )
}
