//
//  TypeDetailsView.swift
//  
//
//  Created Veit Progl on 26.11.22.
//  Copyright © 2022. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

public struct TypeDetailsView: View {
    internal let store: Store<TypeDetailsCore.State, TypeDetailsCore.Action>

    public init(store: Store<TypeDetailsCore.State, TypeDetailsCore.Action>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store) { viewStore in
            Text("Hello world!")
        }
    }
}

struct TypeDetailsView_Preview: PreviewProvider {
    static var previews: some View {
        TypeDetailsView(
            store: Store<TypeDetailsCore.State, TypeDetailsCore.Action>(
                initialState: TypeDetailsCore.State(),
                reducer: TypeDetailsCore.reducer,
                environment: TypeDetailsCore.Environment()
            )
        )
    }
}
