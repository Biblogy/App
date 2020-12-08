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
        sortDescriptors: [NSSortDescriptor(keyPath: \Book.progress, ascending: true)],
        predicate: NSPredicate(format: "done == false"), animation: .default)
        
    private var items: FetchedResults<Book>
    @State private var openAdd = false
    
    var body: some View {
        VStack() {
            Picker("", selection: $selected) {
                        Text("Auto")
                        Text("Light")
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(width: 200)
            Text("Hello, World!")
            
            Button(action: {
                openAdd.toggle()
            }, label:{
                Text("Add Chllenge")
            })
            Spacer()
        }.sheet(isPresented: self.$openAdd, content: {
            AddChallenge(isOpen: self.$openAdd)
        })
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
