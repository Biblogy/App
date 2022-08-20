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
                                AsyncImage(url: URL(string: viewStore.state.book.cover.thumbnail?.replacingOccurrences(of: "http", with: "https") ?? "") ?? URL(string: "")) { image in
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
                            Text(viewStore.state.book?.title ?? "test")
                                .font(.subheadline)
                        }
                        
                        
                    }.listRowBackground(Color.clear)
                    
                    Section(header: Text("Infoamation")) {
                        
                        TextField("Page Count", text: $pageCount)
                        
                        TextField("Verlag", text: $pageCount)
                        
                        TextField("Author", text: $pageCount)
                        
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
                initialState: BookDetailCore.State(),
                reducer: BookDetailCore.reducer,
                environment: BookDetailCore.Environment()
            )
        )
    }
}
