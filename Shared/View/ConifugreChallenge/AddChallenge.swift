//
//  AddChallenge.swift
//  EBookTracking (iOS)
//
//  Created by Veit Progl on 06.12.20.
//

import SwiftUI

struct AddChallenge: View {
    @State private var doesStuff = ""
    @State private var selected = 1
    @State private var menuTime: time = .days
    @Binding var isOpen: Bool

    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Book.title, ascending: true)], animation: .default)
    private var items: FetchedResults<Book>
    
//    @State private var selectedBook = 
    
    var body: some View {
        NavigationView() {
            VStack() {
                Picker("", selection: $selected) {
                    Text("Book")
                    Text("Time")
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(width: 200)
                
                Text("I will read").font(.title).bold()
                HStack() {
                    Text("for").font(.title).bold()
                    Spacer()
                    TextField("10", text: $doesStuff)
                    Menu(self.menuTime.rawValue) {
                        Button("days") { self.menuTime = .days }
                        Button("weeks") { self.menuTime = .weeks }
                        Button("month") { self.menuTime = .month }
                        Button("years") { self.menuTime = .years }
                    }
                }
                HStack() {
                    Text("the book:").font(.title).bold()
                    Spacer()
                    Menu(self.menuTime.rawValue) {
                        Button("days") { self.menuTime = .days }
                        Button("weeks") { self.menuTime = .weeks }
                        Button("month") { self.menuTime = .month }
                        Button("years") { self.menuTime = .years }
                    }
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "xmark")
                    })
                }
                Spacer()
            }
//            .navigationBarTitle("Add a challenge", displayMode: NavigationBarItem.TitleDisplayMode.inline)
            .toolbar(content: {
                ToolbarItem(placement: ToolbarItemPlacement.cancellationAction) {
                    Button(action: {
                        self.isOpen = false
                    }, label: {
                        Text("Close")
                    })
                }
                
                ToolbarItem(placement: ToolbarItemPlacement.confirmationAction) {
                    Button(action: {
                        
                    }, label: {
                        Text("Add")
                    })
                }
            })
            .padding([.top, .leading, .trailing], 20)
        }
        .frame(minWidth: 0, idealWidth: 500, maxWidth: .infinity, minHeight: 300, maxHeight: .infinity)
    }
}
//struct AddChallenge_Previews: PreviewProvider {
//    @State private var isOpen = true
//    static var previews: some View {
//        AddChallenge(isOpen: self.$isOpen)
//    }
//}
