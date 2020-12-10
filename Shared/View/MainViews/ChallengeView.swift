//
//  ChallengeView.swift
//  EBookTracking
//
//  Created by Veit Progl on 05.12.20.
//

import SwiftUI

struct ChallengeView: View {
    @State private var selected = 1
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Challenges.start, ascending: false)], animation: .default)
        
    private var items: FetchedResults<Challenges>
    @State private var openAdd = false
    
    var body: some View {
        VStack() {
            Button(action: {
                openAdd.toggle()
            }, label:{
                Text("Add Chllenge")
            })
            Spacer()
            
            List() {
                ForEach(items) { item in
                    Text(String(item.challengeBook?.title ?? "error"))
                }.onDelete(perform: deleteItems)
            }
        }.sheet(isPresented: self.$openAdd, content: {
            AddChallenge(isOpen: self.$openAdd)
        })
        .padding([.top], 10)
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

enum time:String {
    case days, weeks, month, years
}

struct ChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeView()
    }
}
