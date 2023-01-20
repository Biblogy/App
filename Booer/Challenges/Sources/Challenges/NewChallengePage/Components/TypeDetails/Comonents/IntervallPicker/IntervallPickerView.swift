//
//  IntervallPickerView.swift
//  
//
//  Created Veit Progl on 20.01.23.
//  Copyright © 2023. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

public struct IntervallPickerView: View {
    internal let store: Store<IntervallPickerCore.State, IntervallPickerCore.Action>

    public init(store: Store<IntervallPickerCore.State, IntervallPickerCore.Action>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store) { viewStore in
            Text("Hello world!")
        }
    }
}

struct IntervallPickerView_Preview: PreviewProvider {
    static var previews: some View {
        IntervallPickerView(
            store: Store<IntervallPickerCore.State, IntervallPickerCore.Action>(
                initialState: IntervallPickerCore.State(),
                reducer: IntervallPickerCore.reducer,
                environment: IntervallPickerCore.Environment()
            )
        )
    }
}
