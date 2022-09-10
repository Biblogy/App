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
import CasePaths
import Foundation

struct AppView: View {
    let store: Store<AppCore.State, AppCore.Action>
    
    public init(store: Store<AppCore.State, AppCore.Action>) {
        self.store = store
    }
    
    var body: some View {
        WithViewStore(store) { ViewStore in
            TabView{
                NavigationView {
                    List(){
                        Section(){
                            VStack() {
                                CalenderViewCompact(store: store.scope(state: \.calendar, action: AppCore.Action.calendar))
                            }
                        }
                        Section(){
                            WithViewStore(store) { viewStore in
                                Text(getMonthString(from: viewStore.activeDate))
                                    .padding()
                            }
                        }
                        Section() {
                            BookOverviewView(store: store.scope(state: \.bookOverviewState, action: AppCore.Action.bookOverview))
                        }
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .listRowBackground(Color.clear)
                    }
                }
                .tabItem({ TabLabel(imageName: "house.fill", label: "Home") })
                .tag(1)
                
                AddBookView(store: store.scope(state: \.addBookState, action: AppCore.Action.addBook))
                    .tabItem({ TabLabel(imageName: "plus.magnifyingglass", label: "Search") })
                    .tag(2)
            }
        }
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

struct ContentView: View {
    let store = Store(
        initialState: AppCore.State(),
        reducer: AppCore.reducer.debug(),
        environment: AppCore.Environment()
    )
    
    var body: some View {
        AppView(store: store)
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
