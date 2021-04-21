//
//  CustomAddView.swift
//  EBookTracking
//
//  Created by Veit Progl on 30.11.20.
//

import SwiftUI
import Combine

struct CustomAddView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @Binding var title: String
    @State private var author = ""
    @State private var pages = ""
    @State private var isCorrect = false
    
    var body: some View {
        GroupBox(label: Text("Add Custom Book")) {
            Form() {
                HStack() {
                    Text("Title:")
                    TextField("Title", text: self.$title)
                        .background(
                          RoundedRectangle(cornerRadius: 5)
                            .strokeBorder(Color.secondary, lineWidth: 1)
                        )
                }
                HStack() {
                    Text("Author:")
                    TextField("Author", text: self.$author)
                        .background(
                          RoundedRectangle(cornerRadius: 5)
                            .strokeBorder(Color.secondary, lineWidth: 1)
                        )
                }
                HStack() {
                    Text("Pages:")
                    TextField("Pages", text: self.$pages)
                        .background(
                          RoundedRectangle(cornerRadius: 5)
                            .strokeBorder(Color.secondary, lineWidth: 1)
                        )
                        .onReceive(Just(pages)) { newValue in
                            let filtered = newValue.filter { "0123456789".contains($0) }
                            if filtered != newValue {
                                pages = filtered
                            }
                        }
                        .padding(3)
                    
                    Button(action: {
                        if title != "" && pages != "" {
                            let newItem = Book(context: viewContext)
                            newItem.title = title
                            newItem.progress = 0
                            newItem.author = author
                            newItem.isbn = "000"
                            newItem.year = Date()
                            newItem.id = UUID().uuidString
                            newItem.pages = Float(pages) ?? 0

                            do {
                                try viewContext.save()
                            } catch {
                                // Replace this implementation with code to handle the error appropriately.
                                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                                let nsError = error as NSError
                                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                            }
                        } else {
                            isCorrect = false
                        }
                    }, label: {
                        Text("Add")
                    })
                }
            }
        }
    }
}

//struct CustomAddView_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomAddView()
//    }
//}
