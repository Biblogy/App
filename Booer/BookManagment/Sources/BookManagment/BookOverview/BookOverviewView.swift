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

    let columns = [GridItem(.flexible()),
                   GridItem(.flexible())]

    public var body: some View {
        WithViewStore(store) { viewStore in
            LazyVGrid(columns: columns) {
                ForEach(viewStore.state.books) { book in
                    VStack() {
                        AsyncImage(url: URL(string: book.cover?.thumbnail?.replacingOccurrences(of: "http", with: "https") ?? "") ?? URL(string: "")) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 200, maxHeight: 300)
                        } placeholder: {
                            Color.gray
                        }
                        .cornerRadius(15)
                        Text(book.title)
                    }.onTapGesture {
                        viewStore.send(.navigateDetail(book))
                    }
                }
            }
            .onAppear(perform: {
                viewStore.send(.onAppear)
            })
            .listRowBackground(Color.clear)
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
