//
//  BookDetailCore.swift
//  
//
//  Created Veit Progl on 22.05.22.
//  Copyright © 2022. All rights reserved.
//

import ComposableArchitecture
import DatabaseBooer
public struct BookDetailCore: ReducerProtocol {
    public struct State: Equatable {
        var book: Book
        var addMode: Bool = true
        
        public init(book: Book = Book(title: "")) {
            self.book = book
        }
    }

    public enum Action: Equatable {
        case onAppear
        case onPageCountChanged(Int)
        case onTitleChanged(String)
        case updateButtonTaped
        case onSubtitleChanged(String)
        case delete
    }

    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case let .onPageCountChanged(newText):
                state.book.pageCount = newText
                print(newText)
                return .none
            case let .onTitleChanged(newText):
                state.book.title = newText
                return .none
            case .onAppear:
                return .none
            case let .onSubtitleChanged(newText):
                state.book.subtitle = newText
                return .none
            case .updateButtonTaped:
                state.updateBook(book: state.book)
                return .none
            case .delete:
                state.deleteBook(book: state.book)
                return .none
            }
        }
    }
}

extension BookDetailCore.State {
    func updateBook(book: Book) {
        BiblogyDatabase.shared.books.updateBook(book: book)
    }
    
    func deleteBook(book: Book) {
        BiblogyDatabase.shared.books.deleteBook(book: book)
    }
}
