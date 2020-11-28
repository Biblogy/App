//
//  ContentView.swift
//  Shared
//
//  Created by Veit Progl on 15.11.20.
//

import SwiftUI
import CoreData
import Combine

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.progress, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @State private var showAddView = false
    
    var body: some View {
        List {
            
            ForEach(items) { item in
                BookView(item: ObservableBook(item: item)).padding().background(Color.secondary.opacity(0.3)).cornerRadius(5)
            }
            .onDelete(perform: deleteItems)
        }
        .sheet(isPresented: self.$showAddView, content: {
            AddView(isOpen: self.$showAddView)
        })
        .toolbar {
            #if os(iOS)
            ToolbarItem(placement: .navigationBarTrailing, content: {
                    EditButton()
            })
            
            
            ToolbarItemGroup(placement: .bottomBar, content: {
                Button(action: {showAddView.toggle()}) {
                    Label("Add Item", systemImage: "plus")
                }
            })
            #else
            ToolbarItem(content: {
                Button(action: {showAddView.toggle()}) {
                    Label("Add Item", systemImage: "plus")
                }
            })
            #endif
        }
        
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
            newItem.title = "demo"
            newItem.progress = 0
            newItem.author = "veit"
            newItem.isbn = "w"
            newItem.year = "ww"
            newItem.id = UUID().uuidString

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

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

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
}

class ObservableBook: ObservableObject {
    @Published var item: Item
    @Published var read: String
    
    init(item: Item) {
        self.item = item
        self.read = "\(Int(item.progress))"
    }
}

struct BookView: View {
//    @State var item: Item
    @ObservedObject var item: ObservableBook
    @State private var hasError = false
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        VStack() {
            HStack() {
                VStack() {
                    Text("\(item.item.title!)").font(.title)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    HStack() {
                        Text("Pages: ").bold() +
                        Text(String(Int(item.item.pages)))
                    }.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                }
                
                VStack(alignment: .trailing) {
                    Spacer()
                    if item.item.progress != item.item.pages {
                        TextField("How many Pages?", text: $item.read)
                            .onReceive(Just($item.read)) { newValue in
                                let filtered = newValue.wrappedValue.filter { "0123456789".contains($0) }
                                if filtered != newValue.wrappedValue {
                                    item.read = filtered
                                }
    //
                            }
                            .padding(6)
                            .multilineTextAlignment(.trailing)
                            .font(Font.system(.headline, design: .monospaced).monospacedDigit())
                            .background(
                                        RoundedRectangle(cornerRadius: 5)
                                            .strokeBorder(hasError ? Color.red : Color.secondary, lineWidth: 1)
                                            .background(Color.secondary.opacity(0.4))
                            )
                            .cornerRadius(5.0)
                    } else {
                        Text("Done")
                            .foregroundColor(Color.green)
                            .font(.system(.title))
                            .bold()
                    }
                    
                    if item.item.progress != item.item.pages {
                        Button(action: {
                            let newRead = Float(item.read) ?? item.item.progress
                            print(newRead)
                            if newRead > item.item.pages {
                                hasError = true
                            } else {
                                hasError = false
                                item.item.progress = newRead
                            }
                            
                            if item.item.pages == item.item.progress {
                                item.item.done = true
                                item.item.doneAt = Date()
                            } else {
                                item.item.done = false
                                item.item.doneAt = nil
                            }
                            
    //                        item.item.progress += 5
                            do {
                                try viewContext.save()
                            } catch {
                                // Replace this implementation with code to handle the error appropriately.
                                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                                let nsError = error as NSError
                                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                            }
                            
                        }, label: {
                            Text("Change Read")
                        })
                    } else {
                        Button(action: {
                            item.item.progress -= 1
                            
                            if item.item.pages == item.item.progress {
                                item.item.done = true
                                item.item.doneAt = Date()
                            } else {
                                item.item.done = false
                                item.item.doneAt = nil
                            }
                            
    //                        item.item.progress += 5
                            do {
                                try viewContext.save()
                            } catch {
                                // Replace this implementation with code to handle the error appropriately.
                                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                                let nsError = error as NSError
                                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                            }
                        }, label: {
                            Text("Edit")
                        })
                    }
                }.padding(5)

            }
            
            ProgressView("Read", value: item.item.progress , total: item.item.pages)
                .accentColor(item.item.progress == item.item.pages ? Color.green : Color.blue)
        }.frame(height: 100)
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
