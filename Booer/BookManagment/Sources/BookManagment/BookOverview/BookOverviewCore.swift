//
//  BookOverviewCore.swift
//  
//
//  Created Veit Progl on 02.06.22.
//  Copyright © 2022. All rights reserved.
//

import ComposableArchitecture
import DatabaseBooer
import SwiftUI

public enum BookOverviewCore {}

public extension BookOverviewCore {
    enum Route: Hashable {
        case second(BookDetailCore.State)
    }
    
    struct State: Equatable {
        public init() {}
        public var books: [Book] = []
        var bookDetail = BookDetailCore.State()
        var router: [NavigationPath] = []
    }

    enum Action: Equatable {
        case onAppear
        case bookDetail(BookDetailCore.Action)
        case navigateDetail(Book)
    }

    struct Environment {
        public init() {}
    }

    static let reducer = Reducer<State, Action, Environment>.combine(
        .init { state, action, environment in
            switch action {
            case .onAppear:
                state.books = DatabaseBooer().getAllBooks()
                return .none
            case .bookDetail(_):
                return .none
            case .navigateDetail(let book):
//                state.router.append(book)
                
                return .none
            }
        }
    )
}
