//
//  BookOverviewCore.swift
//  
//
//  Created Veit Progl on 02.06.22.
//  Copyright © 2022. All rights reserved.
//

import ComposableArchitecture
import DatabaseBooer

public struct BookOverviewCore: ReducerProtocol {
    public init() {}
    
    public struct State: Equatable {
        public init() {}
        public var books: [Book] = []
        var bookDetail = BookDetailCore.State()
    }

    public enum Action: Equatable {
        case onAppear
        case bookDetail(BookDetailCore.Action)
        case navigateToDetail(Book)
    }

    public var body: some ReducerProtocol<State, Action> {
        Scope(state: \State.bookDetail, action: /Action.bookDetail) {
            BookDetailCore()
        }
        
        Reduce { state, action in
            switch action {
            case .onAppear:
                state.books = BiblogyDatabase().books.getAllBooks()
                return .none
            case .navigateToDetail(let book):
                state.bookDetail.book = book
                state.bookDetail.addMode = false
                return .none
            case .bookDetail(_):
                return .none
            }
        }
    }
}
