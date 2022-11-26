//
//  BooksListView.swift
//  
//
//  Created Veit Progl on 12.11.22.
//  Copyright © 2022. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

public struct BooksListView: View {
    internal let store: Store<BooksListCore.State, BooksListCore.Action>

    public init(store: Store<BooksListCore.State, BooksListCore.Action>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store) { viewStore in
            GeometryReader { geo in
                ScrollView([.horizontal]) {
                    HStack {
                        Color.gray
                            .cornerRadius(15)
                            .frame(width: geo.size.width / 2.5, height: 210)
                            .overlay {
                                Text("No book")
                                    .foregroundColor(.white)
                            }
                            .overlay(
                                Group{
                                    if viewStore.state.selectedBookId == nil {
                                        RoundedRectangle(cornerRadius: 13)
                                            .stroke(.green, lineWidth: 4)
                                            .padding(2)
                                    } else {
                                        EmptyView()
                                    }
                                }.drawingGroup()
                            )
                            .onTapGesture {
                                viewStore.send(.changeBook(nil))
                            }
                        
                        ForEach(viewStore.state.books) { book in
                            AsyncImage(url: book.cover) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .aspectRatio(contentMode: .fit)
                            } placeholder: {
                                Color.gray
                            }
                            .cornerRadius(15)
                            .frame(width: geo.size.width / 2.5)
                            .overlay(
                                Group{
                                    if viewStore.state.selectedBookId == book.id {
                                        RoundedRectangle(cornerRadius: 13)
                                            .stroke(.green, lineWidth: 4)
                                            .padding(2)
                                    } else {
                                        EmptyView()
                                    }
                                }.drawingGroup()
                            )
                            .onTapGesture {
                                viewStore.send(.changeBook(book.id))
                            }
                        }
                    }
                }
            }
            .onAppear {
                viewStore.send(.onAppear)
            }
        }.frame(height: 210)
    }
}

struct BooksListView_Preview: PreviewProvider {
    static var previews: some View {
        BooksListView(
            store: Store<BooksListCore.State, BooksListCore.Action>(
                initialState: BooksListCore.State(id: "0"),
                reducer: BooksListCore.reducer,
                environment: BooksListCore.Environment()
            )
        )
    }
}
