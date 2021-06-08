//
//  File.swift
//  
//
//  Created by Veit Progl on 03.06.21.
//

import Foundation
import SwiftUI
import Booer_Shared
import Combine

struct LibaryBook: View {
    @State var book: Book
    @State var note = ""
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        Section() {
            VStack() {
                HStack() {
                    VStack() {
                        Text(book.title!)
                            .font(.title)
                            .bold()
                            .multilineTextAlignment(.leading)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        Text(book.author ?? "error")
                            .font(.title3)
                            .multilineTextAlignment(.leading)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    }
                    switch book.state {
                    case .done:
                        Text("Done")
                            .bold()
                            .foregroundColor(Color.green)
                    case .bookshelf:
                        Text("Bookshelf")
                    case .progress:
                        Text("\(Int(book.progress / book.pages * 100))%")
                    }
                }

                HStack() {
                    if book.cover != nil {
                        GeometryReader() {geo in
                            Image(uiImage: UIImage(data: book.cover!)!)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: geo.size.height)
                        }
                        .frame(width: 80)
                        .background(Color(UIImage(data: book.cover!)?.averageColor ?? UIColor.red))
                        .cornerRadius(7)
                        .padding(.bottom, 30)
                        .shadow(radius: 5)

                    } else {
                        GeometryReader() {geo in
                            Image("cover")
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(7)
                                .frame(width: 80, height: geo.size.height)
                        }
                        .frame(width: 80)
                        .padding([.leading, .bottom], 10)
                    }
                    
                    VStack(alignment: .leading){
                        Group() {
                            Text("Information")
                                .font(.headline)
                                .bold()
                            
                            HStack {
                                Text("Added:")
                                Text(book.addedAt ?? Date(), style: .date)
                                    .layoutPriority(1)
                            }
                            
                            HStack {
                                Text("Last read:")
                                Text(Date(), style: .date)
                                    .layoutPriority(1)
                            }
                            
                            HStack {
                                Text("Pages:")
                                Text("\(Int(book.pages))")
                                    .layoutPriority(1)
                            }
                            
                            TextField("Note", text: self.$note)
                        }.padding([.leading], 10)
                        
                        Spacer()
                        
                    }
                    .padding([.bottom], 10)
                    Spacer()
                }
                Picker(selection: $book.state, label: Text("Book State")) {
                    Text("Bookshelf").tag(BookProgressState.bookshelf)
                    Text("Reading").tag(BookProgressState.progress)
                    Text("Done").tag(BookProgressState.done)
                }
                .pickerStyle(SegmentedPickerStyle())
                .onReceive(Just(book.state), perform: { _ in
                    do {
                        try viewContext.save()
                    } catch {
                        // Replace this implementation with code to handle the error appropriately.
                        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                        let nsError = error as NSError
                        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                    }
                })
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100)
        }
        
    }
}

enum displayStateLibary: String {
    case all = "all"
    case done = "done"
    case open = "Bookshelf"
    case progress = "progress"
}

struct LibaryList: View {
    @EnvironmentObject var sheetData: AddSheetData
    @Environment(\.managedObjectContext) private var viewContext
    @State var display: displayStateLibary = .all

    var body: some View {
        NavigationView() {
            List() {
                if display == .all {
                    LibaryListAll()
                } else if display == .done {
                    LibaryListDone()
                } else if display == .progress {
                    LibaryListReading()
                } else if display == .open {
                    LibaryListNotStarted()
                }
            }
            .navigationTitle("Bookshelf: \(display.rawValue)")
            .toolbar(content: {
                ToolbarItem(content: {
                    Button(action: {
                        sheetData.selectedSheet = .AddBook
                        sheetData.isOpen.toggle()
                    }) {
                        Label("Add Item", systemImage: "plus")
                    }
                })
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading, content: {
                    Menu(content: {
                        Button("All") { self.display = .all }
                        Button("Done") { self.display = .done }
                        Button("Open") { self.display = .open }
                        Button("Progress") { self.display = .progress }
                    }, label: {
                        Image(systemName: "line.horizontal.3.decrease.circle")
                            .imageScale(.large)
                    })
                })
            })
        }
    }
}

struct LibaryListNotStarted:View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Book.addedAt, ascending: false)],
        predicate: NSPredicate(format: "stateValue == 1"), animation: .default)
    private var items: FetchedResults<Book>
    
    var body: some View {
        ForEach(items) {book in
            LibaryBook(book: book)
        }
    }
}

struct LibaryListReading:View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Book.addedAt, ascending: false)],
        predicate: NSPredicate(format: "stateValue == 2"), animation: .default)
    private var items: FetchedResults<Book>
    
    var body: some View {
        ForEach(items) {book in
            LibaryBook(book: book)
        }
    }
}

struct LibaryListDone:View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Book.addedAt, ascending: false)],
        predicate: NSPredicate(format: "stateValue == 3"), animation: .default)
    private var items: FetchedResults<Book>
    
    var body: some View {
        ForEach(items) {book in
            LibaryBook(book: book)
        }
    }
}

struct LibaryListAll:View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Book.addedAt, ascending: false)], animation: .default)
    private var items: FetchedResults<Book>
    
    var body: some View {
        ForEach(items) {book in
            if #available(iOS 15.0, *) {
                LibaryBook(book: book)
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            viewContext.delete(book)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
            } else {
                // Fallback on earlier versions
            }
        }
    }
}

struct MyButtonStyle: ButtonStyle {
    var color: Color = .green
    
    public func makeBody(configuration: MyButtonStyle.Configuration) -> some View {
        MyButton(configuration: configuration, color: color)
    }
    
    struct MyButton: View {
        let configuration: MyButtonStyle.Configuration
        let color: Color
        
        var body: some View {
            
            return HStack() {
                Spacer()
                configuration.label
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .foregroundColor(.white)
                    .padding([.leading, .trailing], 15)
                    .padding([.top, .bottom], 10)
                    .background(RoundedRectangle(cornerRadius: 5).fill(color))
                    .compositingGroup()
                    .opacity(configuration.isPressed ? 0.5 : 1.0)
                Spacer()
            }
        }
    }
}
struct LibaryList_Previews: PreviewProvider {
    static var previews: some View {
        LibaryList()
    }
}

extension UIImage {
    var averageColor: UIColor? {
        guard let inputImage = CIImage(image: self) else { return nil }
        let extentVector = CIVector(x: inputImage.extent.origin.x, y: inputImage.extent.origin.y, z: inputImage.extent.size.width, w: inputImage.extent.size.height)

        guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]) else { return nil }
        guard let outputImage = filter.outputImage else { return nil }

        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull as Any])
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)

        return UIColor(red: CGFloat(bitmap[0]) / 255, green: CGFloat(bitmap[1]) / 255, blue: CGFloat(bitmap[2]) / 255, alpha: CGFloat(bitmap[3]) / 255)
    }
}
