//
//  BookOverview.swift
//  Booer-iOS
//
//  Created by Veit Progl on 15.11.20.
//

import SwiftUI
import CoreData
import Combine
import Booer_Shared

public struct BookOverview: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var sheetData: AddSheetData

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Book.addedAt, ascending: false)],
        predicate: NSPredicate(format: "done == false"), animation: .default)
    private var items: FetchedResults<Book>
        
    public var body: some View {
        List() {
            ForEach(items) { item in
                BookView(book: BookModel(item: item, context: viewContext))
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

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}
