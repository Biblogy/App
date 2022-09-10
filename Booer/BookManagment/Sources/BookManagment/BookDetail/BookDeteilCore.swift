//
//  BookDetailCore.swift
//  
//
//  Created Veit Progl on 22.05.22.
//  Copyright © 2022. All rights reserved.
//

import ComposableArchitecture
import DatabaseBooer
public enum BookDetailCore {}

public extension BookDetailCore {
    struct State: Equatable {
        var book: Book
        var title: String
        var addMode: Bool = true
        var todo = Todo()
        
        public init(book: Book = Book(title: "")) {
            self.book = book
            self.title = "test"
        }
    }

    enum Action: Equatable {
        case onAppear
        case onPageCountChanged(Int)
        case onPublisherChanged(String)
        case testTodo(TodoAction)
    }

    struct Environment {
        public init() {}
    }

    static let reducer = Reducer<State, Action, Environment>.combine(
        todoReducer.pullback(state: \.todo, action: /Action.testTodo, environment: {_ in TodoEnvironment() }),
        .init { state, action, environment in
            switch action {
            case let .onPageCountChanged(newText):
                state.book.pageCount = newText
                print(newText)
                return .none
            case let .onPublisherChanged(newText):
                state.title = newText
                print(newText)
                return .none
            case .onAppear:
                return .none
            case .testTodo:
                return .none
            }
        }
    )
}
