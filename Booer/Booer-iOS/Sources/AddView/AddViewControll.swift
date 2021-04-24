//
//  AddViewControll.swift
//  EBookTracking
//
//  Created by Veit Progl on 30.11.20.
//

import Foundation
import SwiftUI
import Combine

struct AddViewControll: View {
    @State var book: BookItem
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        HStack {
            Text("Pages: ")
            TextField("How many Pages?", text: $book.pages.bound)
                .onReceive(Just(book.pages)) { newValue in
                    let filtered = newValue?.filter { "0123456789".contains($0) }
                    if filtered != newValue {
                        book.pages = filtered
                    }
                }
                .background(
                  RoundedRectangle(cornerRadius: 5)
                    .strokeBorder(book.isCorrect ?? false ? Color.red : Color.secondary, lineWidth: 1)
                )
            VStack() {
                Spacer()
                Button(action: {
                    if !(book.pages ?? "").isEmpty {
                        addItem(book: book, viewContext: viewContext)
                    } else {
                        book.isCorrect = true
                    }
                    
                }) {
                    Text("add")
                }.padding([.bottom], 5)
            }
        }.frame(minWidth: 0, maxWidth: .infinity)
    }
}
