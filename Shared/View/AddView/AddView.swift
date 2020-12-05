//
//  AddView.swift
//  EBookTracking
//
//  Created by Veit Progl on 19.11.20.
//

import SwiftUI
import Alamofire
import SDWebImageSwiftUI
import CoreData
import Combine

struct AddView: View {
    @Binding var isOpen: Bool

    var body: some View {
        AddViewIOS(isOpen: $isOpen)
    }
}

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
                    CustomAddView()
                }
                ForEach(books) { book in
                    VStack() {
                        
                        HStack() {
                            DisplayInformation(book: book)
                        }.frame(minWidth: 0, maxWidth: .infinity)
                        
                        AddViewControll(book: book)
                        
                        #if os(OSX)
                        Divider()
                        #endif
                    }
                }
            }
        }
        .padding([.leading, .trailing, .top])
        .toolbar(content: {
            #if os(iOS)
            ToolbarItemGroup(placement: .navigationBarLeading, content: {
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
            #else
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
            #endif
        })
        .frame(minWidth: 0, idealWidth: 500, maxWidth: .infinity, minHeight: 300, maxHeight: .infinity)
    }
} 

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
//        AddView(isOpen: )
        Text("ww")
    }
}
