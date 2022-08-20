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
        var addMode: Bool = true
        
        public init(book: Book = Book(title: "")) {
            self.book = book
        }
    }

    enum Action: Equatable {
        case onAppear
        case onPageCountChanged
    }

    struct Environment {
        public init() {}
    }

    static let reducer = Reducer<State, Action, Environment>.combine(
        .init { state, action, environment in
            return .none
        }
    )
}
