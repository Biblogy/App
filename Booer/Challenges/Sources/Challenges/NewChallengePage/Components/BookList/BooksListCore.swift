//
//  BooksListCore.swift
//  
//
//  Created Veit Progl on 12.11.22.
//  Copyright © 2022. All rights reserved.
//

import ComposableArchitecture

public struct BooksListCore: ReducerProtocol {
    public struct State: Equatable {
        
        // main problem: init is called to many times, database is 4x requested way to often
        public init(id: String?) {
            self.selectedBookId = id
            self.books = DatabaseConnect().getAllBooks()
        }
        
        public var books: [Book] = []
        public var selectedBookId: String?
    }

    public enum Action: Equatable {
        case onAppear
        case changeBook(String?)
    }

    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
            case .changeBook(let bookId):
                state.selectedBookId = bookId ?? nil
                return .none
            }
        }
    }
}
