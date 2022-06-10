//
//  ContentView.swift
//  Shared
//
//  Created by Veit Progl on 18.04.22.
//

import SwiftUI
import ComposableArchitecture
import BooerCalendar
import BookManagment

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
//    @ObservedObject private var iO = Inject.observer
    
    let store = Store(
        initialState: AppState(),
        reducer: appReducer,
        environment: AppEnvironment()
    )
    
    var body: some View {
        VStack() {
            TabView{
                List(){
                    Section(){
                        AppView(store: store)
                    }
                    Section(){
                        WithViewStore(store) { viewStore in
                            Text(getMonthString(from: viewStore.activeDate))
                                .padding()
                        }
                        
                    }
                }
                .tabItem({ TabLabel(imageName: "house.fill", label: "Home") })
                .tag(1)
                
                AddBookView(store: store.scope(state: \.addBookState, action: AppAction.addBook))
                    .tabItem({ TabLabel(imageName: "house.fill", label: "Home") })
                    .tag(2)
            }
        }
//        .enableInjection()
        
    }
    
    func getMonthString(from: Date) -> String {
        let month = Calendar.current.component(.month, from: from)
        let monthString = Calendar.current.monthSymbols[month - 1]
        return monthString
    }
    
    struct TabLabel: View {
       let imageName: String
       let label: String
       
       var body: some View {
           HStack {
               Image(systemName: imageName)
               Text(label)
           }
       }
   }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
