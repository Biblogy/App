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
        var pageCount: Int
        var addMode: Bool = true
        private let bookDB: DatabaseBooer
        
        public init(book: Book = Book(title: "")) {
            self.book = book
            self.title = book.title
            self.pageCount = 0
            self.bookDB = DatabaseBooer.shared
        }
    }

    enum Action: Equatable {
        case onAppear
        case onPageCountChanged(Int)
        case onTitleChanged(String)
        case updateButtonTaped
    }

    struct Environment {
        public init() {}
    }

    static let reducer = Reducer<State, Action, Environment>.combine(
        .init { state, action, environment in
            switch action {
            case let .onPageCountChanged(newText):
                state.book.pageCount = newText
                print(newText)
                return .none
            case let .onTitleChanged(newText):
                state.title = newText
                state.book.title = newText
                return .none
            case .onAppear:
                return .none
            case .updateButtonTaped:
                state.book.title = state.title
                state.book.pageCount = state.pageCount

                state.updateBook(book: state.book)
                return .none
            }
        }
    )
}

extension BookDetailCore.State {
    func updateBook(book: Book) {
        bookDB.updateBook(book: book)
    }
}
