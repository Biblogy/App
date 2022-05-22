//
//  AddBookView.swift
//  
//
//  Created Veit Progl on 13.05.22.
//  Copyright © 2022. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

public struct AddBookView: View {
    internal let store: Store<AddBookCore.State, AddBookCore.Action>
    
    fileprivate struct ViewState: Equatable {
        init(state: AddBookCore.State) {}
    }
    
    fileprivate enum ViewAction: Equatable {
        case onAppear
    }
    
    public init(store: Store<AddBookCore.State, AddBookCore.Action>) {
        self.store = store
    }
    @State private var seach = ""
    
    public var body: some View {
        WithViewStore(
            store.scope(
                state: ViewState.init,
                action: AddBookCore.Action.init
            )
        ) { viewStore in
            NavigationView() {
                VStack() {
                    List() {
                        Section() {
                            HStack{
                                TextField("Seach", text: $seach)
                                Button("Search"){
                                    
                                }
                            }
                        }
                        
                        Section() {
                            ForEach(1...5, id: \.self) { _ in
                                    cell()
                            }
                        }
                    }.listStyle(InsetGroupedListStyle())
                }
                .navigationTitle("Add Book")
            }
        }
    }
}

struct cell: View {
    var body: some View {
        HStack(){
            VStack() {
                Image("someImage")
                    .resizable()
                    .scaledToFill()
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 200, maxHeight: 300)
                    .cornerRadius(15)
                    .padding([.leading], 10)
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            
            VStack() {
                VStack(){
                    Text("Book Title")
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .font(.headline)
                    
                    Text("Author")
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .font(.subheadline)
                        .padding([.bottom], 4)
                    
                    Text("Verlag")
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                    Text("Seiten")
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                }
                Spacer()
                
                Button("Add Book") {
                    
                }
                .buttonStyle(BorderedButtonStyle())
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            
        }.padding([.vertical], 10)
    }
}


extension AddBookCore.Action {
    fileprivate init(action: AddBookView.ViewAction) {
        switch action {
        case .onAppear:
            self = .onAppear
        }
    }
}

struct AddBookView_Preview: PreviewProvider {
    static var previews: some View {
        AddBookView(
            store: Store<AddBookCore.State, AddBookCore.Action>(
                initialState: AddBookCore.State(),
                reducer: AddBookCore.reducer,
                environment: AddBookCore.Environment()
            )
        )
    }
}
