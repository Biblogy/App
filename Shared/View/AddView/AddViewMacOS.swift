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

#if os(OSX)
struct AddViewMacOS: View {
    @Binding var isOpen: Bool
    @State private var bookTitle = "QualityLand"
    @State private var books = [Doc]()
    @Environment(\.managedObjectContext) private var viewContext
        
    var body: some View {
        VStack() {
            TextField("Search", text: $bookTitle)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            List() {
                VStack() {
                    CustomAddView(title: $bookTitle)
                }
                
                if !books.isEmpty {
                    Text("Search Results").font(Font.subheadline).padding([.leading], 7)
                }
                
                ForEach(books) { book in
                    GroupBox() {
                        VStack() {
                            HStack() {
                                DisplayInformation(book: book)
                            }.frame(minWidth: 0, maxWidth: .infinity)
                            
                            AddViewControll(book: book)
                        }
                    }
                }
            }
        }
        .padding([.leading, .trailing, .top])
        .toolbar(content: {
            Button(action: {
                isOpen.toggle()
            }, label: {
                Text("Close")
            })
            
            Button(action: {
                getBooks(bookTitle: bookTitle) { result in
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
        })
        .frame(minWidth: 0, idealWidth: 500, maxWidth: .infinity, minHeight: 300, maxHeight: .infinity)
    }
}
#endif
