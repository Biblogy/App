//
//  IntervallPickerCore.swift
//  
//
//  Created Veit Progl on 20.01.23.
//  Copyright © 2023. All rights reserved.
//

import ComposableArchitecture


public enum IntervallTypes: String, Identifiable {
    public var id: Self {
        return self
    }
        
    case month = "month"
    case year = "year"
    case day = "day"
}

public struct IntervallPickerCore: ReducerProtocol {
    public struct State: Equatable {
        public init(value: String) {
            selectedIntervall = .init(rawValue: value) ?? .month
        }
        
        var selectedIntervall: IntervallTypes = .month
        var selectableIntervallTypes: [IntervallTypes] = [.day, .month, .year]
        var test = "test"
    }

    public enum Action: Equatable {
        case onAppear
        case changeSelection(IntervallTypes)
    }

    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
            case .changeSelection(let newValue):
                state.selectedIntervall = newValue
                return .none
            }
        }
    }
}
