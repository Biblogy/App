//
//  BookDetailView.swift
//  
//
//  Created Veit Progl on 22.05.22.
//  Copyright © 2022. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

public struct BookDetailView: View {
    internal let store: Store<BookDetailCore.State, BookDetailCore.Action>
    
    fileprivate struct ViewState: Equatable {
        init(state: BookDetailCore.State) {}
    }
    
    fileprivate enum ViewAction: Equatable {
        case onAppear
    }
    
    public init(store: Store<BookDetailCore.State, BookDetailCore.Action>) {
        self.store = store
    }
    
    @State private var pageCount = ""
    
    public var body: some View {
        WithViewStore(
            store.scope(
                state: ViewState.init,
                action: BookDetailCore.Action.init
            )
        ) { viewStore in
            VStack() {
                Form {
                    Section() {
                        HStack(){
                            Spacer()
                            Image("someImage")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 200, height: 300, alignment: .center)
                                .cornerRadius(20)
                            Spacer()
                        }
                        
                    }.listRowBackground(Color.clear)
                    
                    Section(header: Text("Infoamation")) {
                        
                        TextField("Page Count", text: $pageCount)
                        
                        TextField("Verlag", text: $pageCount)
                        
                        TextField("Author", text: $pageCount)
                        
                    }
                }
                
                Button("Add Book") {}
                    .buttonStyle(BorderedButtonStyle())
            }.navigationBarItems(trailing: Button("Add", action: {}))
        }
    }
}

extension BookDetailCore.Action {
    fileprivate init(action: BookDetailView.ViewAction) {
        switch action {
        case .onAppear:
            self = .onAppear
        }
    }
}

struct BookDetailView_Preview: PreviewProvider {
    static var previews: some View {
        BookDetailView(
            store: Store<BookDetailCore.State, BookDetailCore.Action>(
                initialState: BookDetailCore.State(),
                reducer: BookDetailCore.reducer,
                environment: BookDetailCore.Environment()
            )
        )
    }
}
