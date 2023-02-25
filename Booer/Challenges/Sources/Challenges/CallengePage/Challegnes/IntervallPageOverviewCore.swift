//
//  IntervallPageOvewviewCore.swift
//  
//
//  Created Veit Progl on 23.02.23.
//  Copyright © 2023. All rights reserved.
//

import ComposableArchitecture

public struct IntervallPageOverviewCore: ReducerProtocol {
    public struct State: Equatable {
        public init() {}
        var challenges: [BookChallenge] = []
    }

    public enum Action: Equatable {
        case onAppear
        case loadAll
    }

    public struct Environment {
        public init() {}
    }

    public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .onAppear:
            return .task {
                return .loadAll
            }
        case .loadAll:
            state.challenges = state.loadAll()
            return .none
        }
    }
}

extension IntervallPageOverviewCore.State {
    func loadAll() -> [BookChallenge] {
        return DatabaseConnect().loadAllIntervallPage()
    }
}
