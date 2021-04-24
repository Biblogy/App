//
//  AddViewMacOS.swift
//  EBookTracking
//
//  Created by Veit Progl on 01.12.20.
//

import SwiftUI
import Alamofire
import SDWebImageSwiftUI
import CoreData
import Combine

class AddBookData: ObservableObject {
    @Published var title = ""
    @Published var progress: Float = 0
    @Published var author = ""
    @Published var isbn = "000"
    @Published var baugtAt = Date()
    @Published var id = UUID().uuidString
    @Published var pages: Decimal?
}

struct AddViewMacOS: View {
    @Binding var isOpen: Bool
    @ObservedObject var book: AddBookData
    @State private var books = [BookItem]()
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        SheetViewModifiyable(content: {
            TextField("Search", text: self.$book.title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding([.leading, .trailing, .top])

            List() {
                if !books.isEmpty {
                    Text("Search Results").font(Font.subheadline).padding([.leading], 7)
                }
                
                ForEach(books) { book in
                    GroupBox() {
                        VStack() {
                            HStack() {
                                DisplayInformation(book: book)
                            }.frame(minWidth: 0, maxWidth: .infinity)
                            
                            Button(action: {
                                self.book.title = book.title ?? ""
                                self.book.author = book.authorName?.first ?? ""
                                self.book.pages = Decimal(Int(book.pages ?? "") ?? 0)
                                self.book.isbn = book.isbn?.first ?? ""
                                
                                self.isOpen.toggle()
                            }, label: {
                                Text("Use")
                            })
                        }
                    }
                }
            }
        }, conformAction: {
            Button(action: {
                getBooks(bookTitle: self.book.title) { result in
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success(let value):
                        books = value
                        print(books)
                    }
                }
            }, label: {
                Text("Search")
            })
        }, cancelAction: {
            isOpen.toggle()
        })
        .onAppear(perform: {
            if self.book.title != "" {
                getBooks(bookTitle: self.book.title) { result in
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success(let value):
                        books = value
                        print(books)
                    }
                }
            }
        })
    }
}
