//
//  AddView.swift
//  
//
//  Created by Veit Progl on 15.05.21.
//

import Foundation
import SwiftUI
import Booer_Shared

struct AddView: View {
    @Binding var isOpen: Bool
    @ObservedObject var book = AddBookData()
    
    @State private var isCorrect = true
    @State private var showSheet = false
    @Environment(\.managedObjectContext) private var viewContext

    @State private var booktitle = ""
    
    public init(isOpen: Binding<Bool>) {
        self._isOpen = isOpen
    }
    
    fileprivate func LabeledTextedField(title: String, textField: Binding<String>) -> some View {
        return HStack() {
            Text(title + ":").bold()
            TextField(title, text: textField)
                .modifier(ShowErrorBorder(isCorrect: self.$isCorrect))
        }.padding(1)
    }
    
    static var numerDottetFormatter: NumberFormatter {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.isLenient = false
        return nf
    }
    
    func saveToDB() {
        if self.book.title != "" && self.book.pages != "" {
            let newItem = Book(context: viewContext)
            newItem.title = self.book.title
            newItem.progress = self.book.progress
            newItem.author = self.book.author
            newItem.isbn = self.book.isbn
            newItem.year = self.book.baugtAt
            newItem.id = self.book.id
            newItem.pages = Float(self.book.pages) ?? 0

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        } else {
            isCorrect = false
        }
    }
    
    var body: some View {
        NavigationView() {
            List() {
                if !isCorrect {
                    Text("There is some required feld missing, plase check")
                        .foregroundColor(Color.red)
                }
                Section(header: Text("Required")) {
                    VStack() {
                        HStack() {
                            LabeledTextedField(title: "Search", textField: self.$book.title)
                            
                            Button(action: {
                                self.showSheet.toggle()
                            }, label: {
                                Image(systemName: "magnifyingglass")
                            })
                        }
                        LabeledTextedField(title: "Author", textField: self.$book.author)
                        
                        HStack() {
                            Text("Pages:").bold()
                            TextField("Pages", text: self.$book.pages)
                                .modifier(ShowErrorBorder(isCorrect: self.$isCorrect))
                        }
                    }
                }
                
                Section(header: Text("Optional")) {
                    DatePicker(selection: self.$book.baugtAt, displayedComponents: .date, label: {
                        Text("Baugt at:").bold()
                    })
                        .datePickerStyle(CompactDatePickerStyle())
                }
            }
            .navigationTitle("Add Book")
            .toolbar(content: {
                ToolbarItem(placement: ToolbarItemPlacement.confirmationAction, content: {
                    Button(action: {
                        self.saveToDB()
                    }, label: {
                        Text("Add")
                    })
                })
                ToolbarItem(placement: ToolbarItemPlacement.cancellationAction, content: {
                    Button(action: {
                        self.isOpen = false
                    }, label: {
                        Text("Canncel")
                    })
                })
            })
        }
        .sheet(isPresented: self.$showSheet, content: {
            SearchBook(isOpen: self.$showSheet, book: book)
        })
    }
}

struct SearchBook: View {
    @Binding var isOpen: Bool
    @ObservedObject var book: AddBookData
    @State private var books = [BookItem]()
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var api = OpenLibary.shared
    
    fileprivate func search() {
        if self.book.title != "" {
            api.getBooks(bookTitle: self.book.title) { result in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let value):
                    books = value
//                    print(books)
                }
            }
        }
    }
    
    var body: some View {
       NavigationView() {
            VStack() {
                List() {
                    HStack() {
                        TextField("Search", text: self.$book.title)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        Button(action: {
                            search()
                        }, label: {
                            Image(systemName: "magnifyingglass")
                        })
                    }
                    
                    
                    if !books.isEmpty {
                        Section(header: Text("Search Results"), content: {
                            ForEach(books) { book in
                                GroupBox() {
                                    VStack() {
                                        HStack() {
                                            DisplayInformation(book: book)
                                        }.frame(minWidth: 0, maxWidth: .infinity)
                                        
                                        Button(action: {
                                            self.book.title = book.title ?? ""
                                            self.book.author = book.authorName?.first ?? ""
                                            self.book.pages = book.pages ?? ""
                                            self.book.isbn = book.isbn?.first ?? ""
                                            
                                            self.isOpen.toggle()
                                        }, label: {
                                            Text("Use")
                                        })
                                    }
                                }
                            }
                        })
                    }
                    
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .frame(minWidth: 0, maxWidth: .infinity)
                }
            }.navigationTitle("Seach Book")
        }
       .toolbar(content: {
            ToolbarItem(placement: ToolbarItemPlacement.cancellationAction, content: {
                Text("Cancel")
            })
       })
        .onAppear(perform: {
            search()
        })
    }
}
