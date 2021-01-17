//
//  BookView.swift
//  EBookTracking
//
//  Created by Veit Progl on 30.11.20.
//

import SwiftUI
import Combine

struct BookView: View {
    @ObservedObject var item: BookModel
    @State private var hasError = false
    @EnvironmentObject var alertData: DeleteAlert
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        GroupBox(){
            HStack(alignment: .top) {
                VStack() {
                    HStack() {
                        VStack() {
                            Text("\(item.item.title ?? "error")").font(.title)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .layoutPriority(1)
                            HStack() {
                                Text("Pages: ").bold() +
                                Text(String(Int(item.item.pages)))
                            }.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        }
                        
                        VStack(alignment: .trailing) {
                            Spacer()
                            if item.item.progress != item.item.pages {
                                TextField("How many Pages?", text: $item.read)
                                    .onReceive(Just($item.read)) { newValue in
                                        let filtered = newValue.wrappedValue.filter { "0123456789".contains($0) }
                                        if filtered != newValue.wrappedValue {
                                            item.read = filtered
                                        }
                                    }
                                    .multilineTextAlignment(.trailing)
                                    .font(Font.system(.headline, design: .monospaced).monospacedDigit())
                                    .background(
                                                RoundedRectangle(cornerRadius: 5)
                                                    .strokeBorder(hasError ? Color.red : Color.secondary, lineWidth: 1)
                                    )
                                    .cornerRadius(5.0)
                                    .frame(maxWidth: 100)
                            } else {
                                Text("Done")
                                    .foregroundColor(Color.green)
                                    .font(.system(.title))
                                    .bold()
                            }
                            
                            if item.item.progress != item.item.pages {
                                Button(action: {
                                    let newRead = Float(item.read) ?? item.item.progress
                                    print(newRead)
                                    hasError = item.updateItem(read: newRead)
                                    item.getChallenge()
                                    
                                    do {
                                        try viewContext.save()
                                    } catch {
                                        // Replace this implementation with code to handle the error appropriately.
                                        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                                        let nsError = error as NSError
                                        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                                    }
                                    
                                }, label: {
                                    Text("Change Read")
                                })
                            } else {
                                Button(action: {
                                    item.editItem()
                                    
                                    do {
                                        try viewContext.save()
                                    } catch {
                                        // Replace this implementation with code to handle the error appropriately.
                                        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                                        let nsError = error as NSError
                                        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                                    }
                                }, label: {
                                    Text("Not Done ?")
                                })
                            }
                        }
                    }
                    
                    ProgressView("Read", value: item.item.progress , total: item.item.pages)
                        .accentColor(item.item.progress == item.item.pages ? Color.green : Color.blue)
                    

                }.frame(height: 100)
                
                Image(systemName: "xmark").onTapGesture {
                    alertData.item = item.item
                    alertData.objectName = item.item.title ?? "error"
                    alertData.type = "book"
                    alertData.show = true
//                    viewContext.delete(item.item)
                    
//                    do {
//                        try viewContext.save()
//                    } catch {
//                        // Replace this implementation with code to handle the error appropriately.
//                        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                        let nsError = error as NSError
//                        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//                    }
                }
            }
        }.onAppear(perform: {
            item.getChallenge()
        })
    }
}

//struct BookView_Previews: PreviewProvider {
//    static var previews: some View {
//        BookView(item: ObservableBook(item: Iten))
//    }
//}
