//
//  TypeDetailsCore.swift
//  
//
//  Created Veit Progl on 26.11.22.
//  Copyright © 2022. All rights reserved.
//

import ComposableArchitecture

public enum TypeDetailsCore {}


/// die Challenge Typem müssen hietr ein Protocoll versteckt werden sodass es hier egal ist welches verwendet wird! Protokolle erlauben das wechseln der Klassen so das es hier flexible bleibt.

public extension TypeDetailsCore {
    struct State: Equatable {
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
