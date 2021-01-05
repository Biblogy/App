//
//  BooksDoneRead.swift
//  EBookTracking
//
//  Created by Veit Progl on 28.11.20.
//

import SwiftUI
import CoreData
import Combine

struct BooksDoneRead: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var sheetData: AddSheetData

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Book.progress, ascending: true)],
        predicate: NSPredicate(format: "done == true"), animation: .default)
    private var items: FetchedResults<Book>
    
    var body: some View {
        List {
            ForEach(items) { item in
                BookView(item: BookModel(item: item))
            }
            .onDelete(perform: deleteItems)
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

struct BooksDoneRead_Previews: PreviewProvider {
    static var previews: some View {
        BooksDoneRead()
    }
}
