//
//  TypeDetailsCore.swift
//  
//
//  Created Veit Progl on 26.11.22.
//  Copyright © 2022. All rights reserved.
//

import ComposableArchitecture
import Foundation

public enum TypeDetailsCore {}


/// die Challenge Typem müssen hietr ein Protocoll versteckt werden sodass es hier egal ist welches verwendet wird! Protokolle erlauben das wechseln der Klassen so das es hier flexible bleibt.

public extension TypeDetailsCore {
    struct State: Equatable {
        let placeholder = ChallengeType(title: "", description: "", fields: [])
        
        public init(selectedType: ChallengeType?) {
            self.selectedType = selectedType ?? placeholder
            
            self.inputFields = IdentifiedArrayOf(
                uniqueElements: self.selectedType.fields.map { field in
                    TypeDetailsFieldCore.State(id: field.id, field: field)
                })
        }
        
        var selectedType: ChallengeType
        var inputFields: IdentifiedArrayOf<TypeDetailsFieldCore.State>
    }

    enum Action: Equatable {
        case onAppear
        case fieldChanged(String)
        case typeDetailsField(id: TypeDetailsFieldCore.State.ID,action: TypeDetailsFieldCore.Action)
    }

    struct Environment {
        public init() {}
    }

    static let reducer = Reducer<State, Action, Environment>.combine(
        AnyReducer { environment in
            TypeDetailsFieldCore()
        }.forEach(state: \.inputFields, action: /TypeDetailsCore.Action.typeDetailsField(id:action:), environment: {$0}),
        .init { state, action, environment in
            switch action {
            case let .fieldChanged(newValue):
                state.selectedType.title = newValue
                return .none
            case .onAppear:
                return .none
            case .typeDetailsField(_, _):
                return .none
            }
        }
    )
}
