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
    @State private var books = [BookItem]()
    @Environment(\.managedObjectContext) private var viewContext
    @State private var addCustomShow = false
    
    var body: some View {
        VStack() {
            
            if !addCustomShow {
                TextField("Search", text: $bookTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding([.leading, .trailing,])
            } else {
                CustomAddView(title: $bookTitle)
                    .padding([.leading, .trailing,])
            }
            List() {
                VStack() {
                    Button(action: {
                        addCustomShow.toggle()
                    }) {
                        Text(self.addCustomShow ? "Back to search" : "Not Found? Add it your self")
                    }.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
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
        .padding([.top])
        .toolbar(content: {
            ToolbarItem(placement: ToolbarItemPlacement.cancellationAction) {
                Button(action: {
                    isOpen.toggle()
                }, label: {
                    Text("Close")
                })
            }
            
            ToolbarItem(placement: ToolbarItemPlacement.confirmationAction) {
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
            }
        })
        .frame(minWidth: 0, idealWidth: 500, maxWidth: .infinity, minHeight: 300, maxHeight: .infinity)
    }
}
#endif
