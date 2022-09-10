//
//  BookDetailView.swift
//  
//
//  Created Veit Progl on 22.05.22.
//  Copyright © 2022. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import DatabaseBooer

public struct BookDetailView: View {
    internal let store: Store<BookDetailCore.State, BookDetailCore.Action>
    
    public init(store: Store<BookDetailCore.State, BookDetailCore.Action>) {
        self.store = store
    }
    
    @State private var pageCount = ""
    
    public var body: some View {
        WithViewStore(store) { viewStore in
            VStack() {
//                TextField("Test", text: viewStore.binding(get: \.title, send: BookDetailCore.Action.onPublisherChanged))
//
//                TodoView(store: store.scope(state: \.todo, action: BookDetailCore.Action.testTodo))
                Form {
                    Section() {
                        VStack() {
                            HStack(){
                                Spacer()
                                AsyncImage(url: URL(string: viewStore.state.book.cover.thumbnail ?? "") ?? URL(string: "")) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(maxHeight: 300, alignment: .center)
                                        .cornerRadius(20)
                                } placeholder: {
                                    Image("someImage")
                                        .resizable()
                                        .scaledToFill()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(maxHeight: 300, alignment: .center)
                                        .cornerRadius(20)
                                }
                                Spacer()
                            }
                            Text(viewStore.state.title)
                                .font(.subheadline)
                        }
                        
                        
                    }.listRowBackground(Color.clear)
                    
                    Section(header: Text("Infoamation")) {
                        HStack() {
                            Text("Page Count: ")
                            
                        }
                        
                        HStack() {
                            Text("Title: ")
                            TextField("Test", text: viewStore.binding(get: \.book.title, send: BookDetailCore.Action.onPublisherChanged))
//                            TextField("Verlag", value: viewStore.binding(get: \.book.publisher, send: BookDetailCore.Action.onPublisherChanged), formatter: NumberFormatter())
                            
//                            Text("Verlag:", text: viewStore.binding(get: \.book.publisher, send: BookDetailCore.Action.onPageCountChanged))
//                                .frame(alignment: .trailing)
//                                .multilineTextAlignment(.trailing)
                        }
                        
//                        TextField("Author", text: viewStore.book?.author)
                        
                    }
                }
                
                if viewStore.addMode {
                    Button("Add Book") {}
                        .buttonStyle(BorderedButtonStyle())
                }
            }
            .navigationBarItems(trailing: Button("Add", action: {}))
        }
    }
}

struct BookDetailView_Preview: PreviewProvider {
    static var previews: some View {
        BookDetailView(
            store: Store<BookDetailCore.State, BookDetailCore.Action>(
                initialState: BookDetailCore.State(book: Book()),
                reducer: BookDetailCore.reducer,
                environment: BookDetailCore.Environment()
            )
        )
    }
}
