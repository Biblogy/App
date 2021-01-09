//
//  ChallengeView.swift
//  EBookTracking
//
//  Created by Veit Progl on 05.12.20.
//

import SwiftUI

struct ChallengeView: View {
    @State private var selected = 1
    
    @EnvironmentObject var sheetData: AddSheetData
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Challenges.start, ascending: false)], animation: .default)
        
    private var items: FetchedResults<Challenges>
    
    var body: some View {
        VStack() {
            List() {
                ForEach(items) { item in
                    ChallengeItemView(data: ChallengeModel(challenge: item))
                }
//                .onDelete(perform: deleteItems)
            }
        }
        .toolbar(content: {
            ToolbarItem(content: {
                Button(action: {
                    sheetData.selectedSheet = .AddChallenge
                    sheetData.isOpen.toggle()
                }) {
                    Label("Add Item", systemImage: "plus")
                }
            })
        })
        .padding([.top], 10)
    }
    
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { items[$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
}

struct ChallengeItemView: View {
    @ObservedObject var data: ChallengeModel
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        HStack() {
            GroupBox() {
                HStack() {
                    Text(String(data.challenge.challengeBook?.title ?? "error"))
                    Spacer()
                    if data.challenge.isFailed {
                        Text("Failed")
                            .foregroundColor(Color.red)
                            .bold()
                    } else if data.challenge.isDone {
                        Text("Done")
                            .foregroundColor(Color.green)
                            .bold()
                    } else {
                        Text(String("\(data.streak)/\(data.challenge.time)"))
                            .foregroundColor(Color.green)
                            .bold()
                    }
                }
                .font(.system(.title))
            }
            Image(systemName: "xmark")
                .onTapGesture {
                    viewContext.delete(data.challenge)
                }
        }
    }
}

enum time:String {
    case days, weeks, month, years
}

struct ChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeView()
    }
}
