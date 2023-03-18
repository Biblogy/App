//
//  CustomSliderCore.swift
//  
//
//  Created Veit Progl on 26.02.23.
//  Copyright © 2023. All rights reserved.
//

import ComposableArchitecture

public struct CustomSliderCore: ReducerProtocol {
    public struct State: Equatable {
        public init(progress: Float, pages: Float) {
            self.progressValue = progress
            self.pages = pages
        }
        
        public var progressValue: Float
        var pages: Float
    }

    public enum Action: Equatable {
        case onAppear
        case progressChanged(Float)
    }

    public struct Environment {
        public init() {}
    }

    public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .onAppear:
            return .none
        case .progressChanged(let progress):
            if progress < state.pages {
                state.progressValue = progress
            }
            return .none
        }
    }
}
