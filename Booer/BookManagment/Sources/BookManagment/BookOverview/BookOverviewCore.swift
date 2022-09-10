//
//  BookOverviewCore.swift
//  
//
//  Created Veit Progl on 02.06.22.
//  Copyright © 2022. All rights reserved.
//

import ComposableArchitecture
import DatabaseBooer

public enum BookOverviewCore {}

public extension BookOverviewCore {
    struct State: Equatable {
        public init() {}
        public var books: [Book] = []
        var bookDetail = BookDetailCore.State()
    }

    enum Action: Equatable {
        case onAppear
        case bookDetail(BookDetailCore.Action)
        case navigateToDetail(Book)
    }

    struct Environment {
        public init() {}
    }

    static let reducer = Reducer<State, Action, Environment>.combine(
        BookDetailCore.reducer.pullback(state: \.bookDetail, action: /Action.bookDetail, environment: { _ in BookDetailCore.Environment() }),
        .init { state, action, environment in
            switch action {
            case .onAppear:
                state.books = DatabaseBooer().getAllBooks()
                return .none
            case .navigateToDetail(let book):
                state.bookDetail.book = book
                state.bookDetail.addMode = false
                return .none
            case .bookDetail(_):
                return .none
            }
        }
    )
}
