//
//  NewChallengePageView.swift
//  
//
//  Created Veit Progl on 03.11.22.
//  Copyright © 2022. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

public struct NewChallengePageView: View {
    internal let store: Store<NewChallengePageCore.State, NewChallengePageCore.Action>

    public init(store: Store<NewChallengePageCore.State, NewChallengePageCore.Action>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store) { viewStore in
            GeometryReader { geo in
                List() {
                    Section("select a book") {
                        ScrollView([.horizontal]) {
                            HStack {
                                Color.gray
                                    .cornerRadius(15)
                                    .frame(width: geo.size.width / 2.5, height: 250)
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
                        .listRowBackground(Color.clear)
                    }
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    
                    Section("challenge type") {
                        
                    }
                }
            }
            .navigationTitle("Create a challenge")
            .onAppear(perform: {
                viewStore.send(.onAppear)
            })
        }
    }
}

struct NewChallengePageView_Preview: PreviewProvider {
    static var previews: some View {
        NewChallengePageView(
            store: Store<NewChallengePageCore.State, NewChallengePageCore.Action>(
                initialState: NewChallengePageCore.State(),
                reducer: NewChallengePageCore.reducer,
                environment: NewChallengePageCore.Environment()
            )
        )
    }
}
