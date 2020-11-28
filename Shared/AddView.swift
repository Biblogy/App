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
    @State private var bookTitle = "QualityLand"
    @State private var books = [Doc]()
    @Environment(\.managedObjectContext) private var viewContext
    
    
    fileprivate func DisplayInformation(book: Doc) -> some View {
        return VStack(alignment: .leading) {
            Text(book.title).font(.headline)
            //                    Text(book.publishYear)
            Text("Author:")
            
            ForEach(Array(Set(book.authorName)), id: \.self) { name in
                Text(name)
            }
            
            Text("Date:")
            
            ForEach(Array(Set(arrayLiteral: String("\(book.publishYear)"))), id: \.self) { date in
                Text(date)
            }
            Spacer()
        }.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
    }
    
    var body: some View {
        NavigationView() {
                VStack() {
                    TextField("Search", text: $bookTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    List(books) { book in
                        VStack() {
                            
                            HStack() {
                                DisplayInformation(book: book)
                            }.frame(minWidth: 0, maxWidth: .infinity)
                            
                            Controll(book: book)
                            
                            #if os(OSX)
                            Divider()
                            #endif
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
        }
        .frame(minWidth: 0, idealWidth: 500, maxWidth: .infinity, minHeight: 300, maxHeight: .infinity)
    }
}

fileprivate struct Controll: View {
    @State var book: Doc
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        HStack {
            Text("Pages: ")
            TextField("How many Pages?", text: $book.pages.bound)
                .onReceive(Just(book.pages)) { newValue in
                    let filtered = newValue?.filter { "0123456789".contains($0) }
                    if filtered != newValue {
                        book.pages = filtered
                    }
                }
                .padding(3)
                .background(
                  RoundedRectangle(cornerRadius: 5)
                    .strokeBorder(book.isCorrect ?? false ? Color.red : Color.secondary, lineWidth: 1)
                )
            VStack() {
                Spacer()
                Button(action: {
                    if !(book.pages ?? "").isEmpty {
                        addItem(book: book, viewContext: viewContext)
                    } else {
                        book.isCorrect = true
                    }
                    
                }) {
                    Text("add")
                }.padding([.bottom], 5)
            }
        }.frame(minWidth: 0, maxWidth: .infinity)
    }
}

extension Optional where Wrapped == String {
    var _bound: String? {
        get {
            return self
        }
        set {
            self = newValue
        }
    }
    public var bound: String {
        get {
            return _bound ?? ""
        }
        set {
            _bound = newValue.isEmpty ? nil : newValue
        }
    }
}

func getBooks(bookTitle: String, completion: @escaping (Result<[Doc], Error>) -> Void) {
    print("=====")
    let url = "https://openlibrary.org/search.json?title=\(bookTitle)"
    print(url)
//    var books = [Doc]()
    AF.request(url, method: .get)
        .validate()
        .responseDecodable(of: Welcome.self) { (response) in
//            guard let searchResponse = response.value else { return }
//            return searchResponse.docs
            switch response.result {
            case .success(let value):
                completion(.success(value.docs))
            case .failure(let error):
                completion(.failure(error))
            }
        }
}

private func addItem(book: Doc, viewContext: NSManagedObjectContext) {
//    let viewContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)

    withAnimation {
        let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
        newItem.title = book.title
        newItem.progress = 0
        newItem.author = "veit"
        newItem.isbn = "w"
        newItem.year = "ww"
        newItem.id = UUID().uuidString
        newItem.pages = Float(book.pages ?? "0") ?? 0

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



struct AddView_Previews: PreviewProvider {
    static var previews: some View {
//        AddView(isOpen: )
        Text("ww")
    }
}
