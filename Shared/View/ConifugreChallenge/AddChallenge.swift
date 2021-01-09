//
//  AddChallenge.swift
//  EBookTracking (iOS)
//
//  Created by Veit Progl on 06.12.20.
//

import SwiftUI

class challengeData: ObservableObject {
    @Published var bookID: String = "-404"
    @Published var bookTitle: String
    @Published var book: Book?
    
    init(bookTitle: String) {
        self.bookTitle = bookTitle
    }
}

struct AddChallenge: View {
    @State private var time = ""
    @State private var selected = 1
    @State private var menuTime: time = .days
    @Binding var isOpen: Bool

    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Book.title, ascending: true)], predicate: NSPredicate(format: "done != true"), animation: .default)
    private var items: FetchedResults<Book>
    
    @ObservedObject var data = challengeData(bookTitle: "select a book")
    
    var body: some View {
//        NavigationView() {
            VStack() {
//                Picker("", selection: $selected) {
//                    Text("Book")
//                    Text("Time")
//                }
//                .pickerStyle(SegmentedPickerStyle())
//                .frame(width: 200)
                
                Text("I will read").font(.title).bold().frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                HStack() {
                    Text("for").font(.title).bold()
                    Spacer()
                    TextField("10", text: $time)
                    Text("days").font(.title).bold()
//                    Menu(self.menuTime.rawValue) {
//                        Button("days") { self.menuTime = .days }
//                        Button("weeks") { self.menuTime = .weeks }
//                        Button("month") { self.menuTime = .month }
//                        Button("years") { self.menuTime = .years }
//                    }
                }
                HStack() {
                    Text("the book:").font(.title).bold()
                    Spacer()
                    Menu(self.data.bookTitle) {
                        Button(action: {
                            self.data.bookTitle = "select a book"
                            self.data.bookID = "-404"
                            self.data.book = nil
                            print(self.data)
                        }, label: {
                            Text("select a book")
                        })
                        ForEach(items) { book in
                            Button(action: {
                                self.data.bookTitle = book.title ?? "error"
                                self.data.bookID = book.id ?? "-404"
                                self.data.book = book
                                print(self.data)
                            }, label: {
                                Text("\(book.title ?? "error")")
                            })
                        }
                    }
                }
                Spacer()
            }
//            .navigationBarTitle("Add a challenge", displayMode: NavigationBarItem.TitleDisplayMode.inline)
            .toolbar(content: {
                ToolbarItem(placement: ToolbarItemPlacement.cancellationAction) {
                    Button(action: {
                        self.isOpen = false
                    }, label: {
                        Text("Close")
                    })
                }

                ToolbarItem(placement: ToolbarItemPlacement.confirmationAction) {
                    Button(action: {
                        if self.data.book != nil {
                            addChallenge(bookId: data.bookID, time: Int16(time) ?? -404, timeType: menuTime.rawValue, book: self.data.book!)
                        }
                    }, label: {
                        Text("Add")
                    })
                }
            })
            .padding([.top, .leading, .trailing], 20)
            .frame(minWidth: 0, idealWidth: 500, maxWidth: .infinity, minHeight: 300, maxHeight: .infinity)
//    }
    }

    func addChallenge(bookId: String, time: Int16, timeType: String, book: Book) {
        let newItem = Challenges(context: viewContext)
        newItem.id = UUID().uuidString
        newItem.time = time
        newItem.timeType = timeType
        newItem.start = Date()
        newItem.book = bookId
        newItem.challengeBook = book

        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
//struct AddChallenge_Previews: PreviewProvider {
//    @State private var isOpen = true
//    static var previews: some View {
//        AddChallenge(isOpen: self.$isOpen)
//    }
//}
