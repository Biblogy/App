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

public struct BookOverview: View {
    @EnvironmentObject var sheetData: AddSheetData
    @EnvironmentObject var alertData: DeleteAlert
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: ReadProgress.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \ReadProgress.date, ascending: false)])
    var items: FetchedResults<ReadProgress>
    
    public var body: some View {

        List() {
            Section() {
                HStack(spacing: 15) {
    //                DashCell(data: DashboardModel(items: items))
    //                DashCell(data: DashboardModel(items: items))
    //                DashCell(data: DashboardModel(items: items))
                    VStack() {
                        Text("12")
                            .font(.headline)
                        Text("days of reading")
                        Text("in streak")
                            .font(.subheadline)
                    }.frame(minWidth: 0, maxWidth: .infinity)
                    
                    Divider()
                    
                    VStack() {
                        Text("10")
                            .font(.headline)
                        Text("books finished")
                        Text("in streak")
                            .font(.subheadline)
                    }.frame(minWidth: 0, maxWidth: .infinity)
                    
                    Divider()
                    
                    VStack() {
                        Text("300")
                            .font(.headline)
                        Text("min read")
                        Text("in streak")
                            .font(.subheadline)
                    }.frame(minWidth: 0, maxWidth: .infinity)
                }
            }
            Section() {
                displayAll()
            }
        }
    }
    
    struct displayAll: View {
        @Environment(\.managedObjectContext) private var viewContext
        @FetchRequest(
            sortDescriptors: [NSSortDescriptor(keyPath: \Book.addedAt, ascending: false)],
            predicate: NSPredicate(format: "stateValue == 2"), animation: .default)
        private var items: FetchedResults<Book>
        
        var body: some View {
            if items.isEmpty {
                Button(action: {
                    
                }, label: {
                    Button(action: {

                    }) {
                        HStack {
                            Spacer()
                            VStack() {
                                Image(systemName: "book")
                                .resizable()
                                .frame(width: 50, height: 50)
                                
                                Text("You don't read a book curently")
                            }
                            Spacer()
                        }
                    }
                })
            } else {
                ForEach(items) { item in
                    BookView(book: BookModel(item: item, context: viewContext))
                }
            }
        }
    }
}
