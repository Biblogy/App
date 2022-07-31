//
//  BookOverviewView.swift
//  
//
//  Created Veit Progl on 02.06.22.
//  Copyright © 2022. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import DatabaseBooer

public struct BookOverviewView: View {
    internal let store: Store<BookOverviewCore.State, BookOverviewCore.Action>

    public init(store: Store<BookOverviewCore.State, BookOverviewCore.Action>) {
        self.store = store
    }

    let columns = [GridItem(.flexible(), alignment: .top),
                   GridItem(.flexible(), alignment: .top)]

    public var body: some View {
        WithViewStore(store) { viewStore in
           LazyVGrid(columns: columns) {
               ForEach(viewStore.state.books) { idx in
                   BookCoverView(store: store, book: idx)
               }
           }.onAppear(perform: {
               viewStore.send(.onAppear)
           })
        }
    }
}

public struct BookCoverView: View {
    internal let store: Store<BookOverviewCore.State, BookOverviewCore.Action>
    internal let book: Book
    @State private var isActive = false

    public init(store: Store<BookOverviewCore.State, BookOverviewCore.Action>, book: Book) {
        self.store = store
        self.book = book
    }
    
    public var body: some View {
        WithViewStore(store) { viewStore in
            VStack() {
                AsyncImage(url: URL(string: book.cover?.thumbnail?.replacingOccurrences(of: "http", with: "https") ?? "") ?? URL(string: "")) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    Color.gray
                }
                .cornerRadius(15)
                Text(book.title)
            }
            .onTapGesture {
                viewStore.send(.navigateToDetail(book))
                isActive.toggle()
            }
            .background(
                NavigationLink (
                    destination: BookDetailView(store: store.scope(state: \.bookDetail, action: BookOverviewCore.Action.bookDetail)),
                    isActive: $isActive,
                    label: {
                        EmptyView()
                    }
                )
            )
        }
    }
}

struct BookOverviewView_Preview: PreviewProvider {
    static var previews: some View {
        BookOverviewView(
            store: Store<BookOverviewCore.State, BookOverviewCore.Action>(
                initialState: BookOverviewCore.State(),
                reducer: BookOverviewCore.reducer,
                environment: BookOverviewCore.Environment()
            )
        )
    }
}
