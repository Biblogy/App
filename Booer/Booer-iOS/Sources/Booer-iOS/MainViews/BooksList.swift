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

enum DashCellState: String {
    case total = "Total"
    case day = "Today"
    case streak = "Streak"
}

struct DashCell: View {
    @State var displayType: DashCellState = .streak
    @ObservedObject var data: DashboardModel
    var body: some View {
        return Group {
            VStack() {
                Text(displayType.rawValue)
                Text("\(data.calcStreak())")
                    .font(.headline)
                Text("days streak")
            }.padding(5)
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .background(Color.gray.opacity(0.3))
        .cornerRadius(5)
        .onTapGesture {
            switch displayType {
            case .streak:
                self.displayType = .day
            case .day:
                self.displayType = .total
            case .total:
                self.displayType = .streak
            }
        }
    }
}




enum displayState: String {
    case all = "all"
    case done = "done"
    case open = "open"
}
public struct BookOverview: View {
    @EnvironmentObject var sheetData: AddSheetData
    @EnvironmentObject var alertData: DeleteAlert
    @State var display: displayState = .all
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: ReadProgress.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \ReadProgress.date, ascending: false)])
    var items: FetchedResults<ReadProgress>
    
    public var body: some View {

        List() {
            HStack(spacing: 15) {
                DashCell(data: DashboardModel(items: items))
                DashCell(data: DashboardModel(items: items))
                DashCell(data: DashboardModel(items: items))
            }
            
            if display == .done {
                displayClose()
            } else if display == .open {
                displayOpen()
            } else if display == .all {
                displayAll()
            }
        }
        .toolbar(content: {
            ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading, content: {
                Menu(content: {
                    Button("All") { self.display = .all }
                    Button("Done") { self.display = .done }
                    Button("Open") { self.display = .open }
                }, label: {
                    Image(systemName: "line.horizontal.3.decrease.circle")
                        .imageScale(.large)
                })
            })
        })
    }
    
    struct displayAll: View {
        @Environment(\.managedObjectContext) private var viewContext
        @FetchRequest(
            sortDescriptors: [NSSortDescriptor(keyPath: \Book.addedAt, ascending: false)], animation: .default)
        private var items: FetchedResults<Book>
        
        var body: some View {
            ForEach(items) { item in
                BookView(book: BookModel(item: item, context: viewContext))
            }
        }
    }
    
    struct displayOpen: View {
        @Environment(\.managedObjectContext) private var viewContext
        @FetchRequest(
            sortDescriptors: [NSSortDescriptor(keyPath: \Book.addedAt, ascending: false)],
            predicate: NSPredicate(format: "done == false"), animation: .default)
        private var items: FetchedResults<Book>
        
        var body: some View {
            ForEach(items) { item in
                BookView(book: BookModel(item: item, context: viewContext))
            }
        }
    }
    
    struct displayClose: View {
        @Environment(\.managedObjectContext) private var viewContext
        @FetchRequest(
            sortDescriptors: [NSSortDescriptor(keyPath: \Book.addedAt, ascending: false)],
            predicate: NSPredicate(format: "done == true"), animation: .default)
        private var items: FetchedResults<Book>
        
        var body: some View {
            ForEach(items) { item in
                BookView(book: BookModel(item: item, context: viewContext))
            }
        }
    }
}
