//
//  ContentView.swift
//  Shared
//
//  Created by Veit Progl on 18.04.22.
//

import SwiftUI
import Inject
import ComposableArchitecture

struct AppView: View {
    let store: Store<AppState, AppAction>

    public init(store: Store<AppState, AppAction>) {
      self.store = store
    }
    
    var body: some View {
        VStack() {
            CalenderViewCompact(store: store.scope(state: \.calendar, action: AppAction.calendar))
        }
    }
}

struct ContentView: View {
    @ObservedObject private var iO = Inject.observer
    
    let store = Store(
      initialState: AppState(),
      reducer: appReducer,
      environment: AppEnvironment()
    )
    
    var body: some View {
        VStack() {
            AppView(store: store)
            
            Text("Hello, world!")
                .padding()
        }.enableInjection()
       
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
