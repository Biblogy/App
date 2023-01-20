//
//  TypeDetailsCore.swift
//  
//
//  Created Veit Progl on 26.11.22.
//  Copyright © 2022. All rights reserved.
//

import ComposableArchitecture
import Foundation

/// die Challenge Typem müssen hietr ein Protocoll versteckt werden sodass es hier egal ist welches verwendet wird! Protokolle erlauben das wechseln der Klassen so das es hier flexible bleibt.

public struct TypeDetailsCore: ReducerProtocol {
    public struct State: Equatable {
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

    public enum Action: Equatable {
        case onAppear
        case fieldChanged(String)
        case typeDetailsField(id: TypeDetailsFieldCore.State.ID,action: TypeDetailsFieldCore.Action)
    }

//    public struct Environment {
//        public init() {}
//    }
    
    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case let .fieldChanged(newValue):
                state.selectedType.title = newValue
                return .none
            case .onAppear:
                return .none
            case .typeDetailsField(id: _, action: _):
                return .none
            }
        }.forEach(\.inputFields, action: /Action.typeDetailsField) {
            TypeDetailsFieldCore()
        }
    }
}
