//
//  AddChallenge.swift
//  EBookTracking (iOS)
//
//  Created by Veit Progl on 06.12.20.
//

import SwiftUI
import Combine

class AddChallangeData: ObservableObject {
    @Published var isNotValid = false
    @Published var menuTime: time = .days
    @Published var selected = 1
    @Published var time = ""
}

struct AddChallenge: View {
    @Binding var isOpen: Bool
    
    @ObservedObject var addChallangeData = AddChallangeData()
    @ObservedObject var data = challengeData(bookTitle: "select a book")
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
            VStack() {
                Text("I will read")
                    .font(.title).bold()
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
                daysTextField(addChallangeData: addChallangeData)
                bookPicker(addChallangeData: addChallangeData, data: data)
                Spacer()
            }
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
                        validatingData(bookId: data.bookID, time: Int16(addChallangeData.time) ?? -404, timeType: addChallangeData.menuTime.rawValue, book: self.data.book)
                        if !addChallangeData.isNotValid {
                            addChallenge(bookId: data.bookID, time: Int16(addChallangeData.time) ?? -404, timeType: addChallangeData.menuTime.rawValue, book: self.data.book!)
                        }
                    }, label: {
                        Text("Add")
                    })
                }
            })
            .padding([.top, .leading, .trailing], 20)
            .frame(minWidth: 0, idealWidth: 500, maxWidth: .infinity, minHeight: 300, maxHeight: .infinity)
    }
    
    func validatingData(bookId: String, time: Int16, timeType: String, book: Book?) {
        if bookId != "" &&
            time != -404 &&
            timeType != "" &&
            book != nil {
            self.addChallangeData.isNotValid = false
        } else {
            self.addChallangeData.isNotValid = true
        }
    }
    
    func addChallenge(bookId: String, time: Int16, timeType: String, book: Book) {
            let newItem = Challenges(context: viewContext)
            newItem.id = UUID().uuidString
            newItem.time = time
            newItem.timeType = timeType
            newItem.start = Date()
            newItem.book = bookId
            newItem.challengeBook = book

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

//struct AddChallenge_Previews: PreviewProvider {
//    @State private var isOpen = true
//    static var previews: some View {
//        AddChallenge(isOpen: self.$isOpen)
//    }
//}
