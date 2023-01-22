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
                            Text(viewStore.state.book.title)
                                .font(.subheadline)
                        }
                    }.listRowBackground(Color.clear)
                    
                    Section {
                        if #available(iOS 16.0, *) {
                            TextField("Buch Subtitle", text: viewStore.binding(get: \.book.subtitle, send: BookDetailCore.Action.onSubtitleChanged), axis: .vertical)
                        } else {
                            TextField("Buch Subtitle", text: viewStore.binding(get: \.book.subtitle, send: BookDetailCore.Action.onSubtitleChanged))
                        }
                    }
                    
                    Section(header: Text("Infoamation")) {
                        HStack() {
                            Text("Title: ")
                            TextField("Buch Titel", text: viewStore.binding(get: \.book.title, send: BookDetailCore.Action.onTitleChanged))
                                .frame(alignment: .trailing)
                                .multilineTextAlignment(.trailing)
                                
                        }
                        
                        HStack() {
                            Text("Page Count: ")
                            TextField("Page Count:", value: viewStore.binding(get: \.book.pageCount, send: BookDetailCore.Action.onPageCountChanged), format: .number)
                                .frame(alignment: .trailing)
                                .multilineTextAlignment(.trailing)
                        }
                    }
                    
                    Section(header: Text("Danger zone")) {
                        Button("Delete") {
                            viewStore.send(BookDetailCore.Action.delete)
                        }
                        .foregroundColor(.red)
                    }
                }
                
                if viewStore.addMode {
                    Button("Add Book") {}
                        .buttonStyle(BorderedButtonStyle())
                }
            }
            .navigationBarItems(trailing: viewStore.state.addMode ? Button("Add", action: {}) : Button("Update", action: {viewStore.send(.updateButtonTaped)}))
        }
    }
}

struct BookDetailView_Preview: PreviewProvider {
    static var previews: some View {
        BookDetailView(
            store: Store(initialState: BookDetailCore.State(), reducer: BookDetailCore())
        )
    }
}
