//
//  BookView.swift
//  EBookTracking
//
//  Created by Veit Progl on 30.11.20.
//

import SwiftUI
import Combine

private struct customSlider: View {
    @Binding var progress: Float
    @Binding var pages: Float
    @Binding var read: String
    
    let formatter: NumberFormatter = {
       let formatter = NumberFormatter()
       formatter.numberStyle = .decimal
       return formatter
    }()
    
    var body: some View {
        VStack() {
            HStack() {
                Text("0")
                Spacer()
                Text("\(Int(pages))")
            }.padding([.bottom], -5)
            Slider(value: $progress, in: 0...pages, step: 1)
            GeometryReader { geometry in
                HStack() {
                    TextField("read pages", value: $progress, formatter: formatter)
                        .position(x: CGFloat(progress) * geometry.size.width / CGFloat(pages))
                        .frame(alignment: .center)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: 100)
                }
            }.padding([.leading, .trailing], 12)
        }
    }
}

public struct BookView: View {
    @ObservedObject var item: BookModel
    @State private var hasError = false
    @EnvironmentObject var alertData: DeleteAlert
    @Environment(\.managedObjectContext) private var viewContext

    public init(book: BookModel) {
        self.item = book
    }
    
    public var body: some View {
            HStack(alignment: .top) {
                if item.item.cover != nil {
                    GeometryReader() {geo in
                        Image(uiImage: UIImage(data: item.item.cover!)!)
                            .resizable()
                            .frame(width: 100, height: geo.size.height)
                            .scaledToFill()
                    }.frame(width: 100)
                    .padding([.trailing], -10)
                }
                VStack(alignment: .trailing) {
                    HStack(alignment: .top) {
                        Text("\(item.item.title ?? "error")").font(.title)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .layoutPriority(1)
                        Spacer()
                        Image(systemName: "xmark").onTapGesture {
                            alertData.item = item.item
                            alertData.objectName = item.item.title ?? "error"
                            alertData.alertType = .delete
                            alertData.type = "book"
                            alertData.show = true
                        }
                    }
                    customSlider(progress: $item.item.progress, pages: $item.item.pages, read: $item.read)
                        .padding([.top], 10)

//                    if item.item.progress != item.item.pages {
//                        Button(action: {
//                            let newRead = Float(item.read) ?? item.item.progress
//                            print(newRead)
//                            hasError = item.updateItem(read: newRead)
//                            item.getChallenge()
//
//                            do {
//                                try viewContext.save()
//                            } catch {
//                                // Replace this implementation with code to handle the error appropriately.
//                                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                                let nsError = error as NSError
//                                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//                            }
//
//                        }, label: {
//                            Text("Change Read")
//                        })
//                    } else {
//                        Button(action: {
//                            item.editItem()
//
//                            do {
//                                try viewContext.save()
//                            } catch {
//                                // Replace this implementation with code to handle the error appropriately.
//                                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                                let nsError = error as NSError
//                                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//                            }
//                        }, label: {
//                            Text("Not Done ?")
//                        })
//                    }
                }
                .padding()
        }
        .frame(minHeight: 100)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
        .onAppear(perform: {
            item.getChallenge()
        })
    }
}

//struct BookView_Previews: PreviewProvider {
//    static var previews: some View {
//        BookView(item: ObservableBook(item: Iten))
//    }
//}
