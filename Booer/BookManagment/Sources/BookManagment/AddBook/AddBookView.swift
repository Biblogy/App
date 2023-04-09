//
//  AddBookView.swift
//  
//
//  Created Veit Progl on 13.05.22.
//  Copyright © 2022. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import DatabaseBooer
import BooerKit

public struct AddBookView: View {
    internal let store: Store<AddBookCore.State, AddBookCore.Action>
    
    public init(store: Store<AddBookCore.State, AddBookCore.Action>) {
        self.store = store
    }
    @State private var seach = ""
    
    public var body: some View {
        WithViewStore(self.store) { viewStore in
            NavigationView() {
                VStack() {
                    List() {
                        Section() {
                            ForEach(viewStore.state.books) { book in
                                NavigationLink(destination: BookDetailView(store: store.scope(state: \.bookDetail, action: AddBookCore.Action.bookDetail))) {
                                    cell(book: book, viewStore: viewStore)
                                }
                            }
                        }
                    }.listStyle(InsetGroupedListStyle())
                    .overlay(Divider(), alignment: .bottom)
                    
                    VStack() {
                        HStack{
                            TextField("Seach", text: $seach)
                                .textContentType(.name)
                            Button("Search"){
                                viewStore.send(.requestBook("Die 4 Stunden Woche"))
                            }
                        }
                            .ignoresSafeArea(.keyboard, edges: .bottom)
                            .padding([.horizontal], 17)
                            .padding([.vertical], 10)
                            .cornerRadius(9)
                            .overlay(
                                RoundedRectangle(cornerRadius: 9)
                                        .stroke(.blue, lineWidth: 2)
                            )
                            .padding()
                    }
                }
                .navigationTitle("Add Book")
            }
        }
    }
}

struct cell: View {
    var book: Book
    var viewStore: ViewStore<AddBookCore.State, AddBookCore.Action>
    
    var body: some View {
        HStack(){
            VStack() {
                AsyncImage(url: URL(string: book.cover.thumbnail ?? "") ?? URL(string: "")) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 200, maxHeight: 300)
                } placeholder: {
                    Color.gray
                }
                .cornerRadius(15)
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            
            VStack() {
                VStack(){
                    Text(book.title)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .font(.headline)
                    
                    Text("\(book.author.first ?? "")")
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .font(.subheadline)
                        .padding([.bottom], 4)
                    
                    Text("\(book.publisher ?? "")")
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                    Text("Seiten: \(Int(book.pageCount))")
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                }
                Spacer()
                
                Button("Add Book") {
                    viewStore.send(.saveBook(book))
                }
                .buttonStyle(BorderedButtonStyle())
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            
        }.padding([.vertical], 10)
    }
}
