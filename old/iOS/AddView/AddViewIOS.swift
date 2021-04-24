//
//  AddViewIOS.swift
//  EBookTracking
//
//  Created by Veit Progl on 01.12.20.
//

import SwiftUI
import Alamofire
import SDWebImageSwiftUI
import CoreData
import Combine

#if os(iOS)
struct AddViewIOS: View {
    @Binding var isOpen: Bool
    @State private var bookTitle = "QualityLand"
    @State private var books = [BookItem]()
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        NavigationView() {
            VStack() {
                List() {
                    TextField("Search", text: $bookTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                
                    VStack() {
                        CustomAddView(title: $bookTitle)
                    }
                    ForEach(books) { book in
                        VStack() {
                            
                            HStack() {
                                DisplayInformation(book: book)
                            }.frame(minWidth: 0, maxWidth: .infinity)
                            
                            AddViewControll(book: book)
                        }
                    }
                }
            }
            .navigationBarTitle("Add View")
            .toolbar(content: {
                ToolbarItemGroup(placement: .navigationBarTrailing, content: {
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
            })
        }
    }
}
#endif
