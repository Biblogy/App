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
