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
        var book: Book?
        
        public init() {}
    }

    enum Action: Equatable {
        case onAppear
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
