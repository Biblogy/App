import SwiftUI
import Booer_Shared

public struct TestIos: View {
    public init() {}
    
    public var body: some View {
        TabView {
           NavigationIos()
               .tabItem { Label("Books to read", systemImage: "text.book.closed.fill") }
//            TimeCounter()
//                .tabItem { Label("Timer", systemImage: "stopwatch") }
            LibaryList()
                .tabItem { Label("Bookshelf", systemImage: "books.vertical.fill") }
            ChallengeList()
                .tabItem { Label("Challenges", systemImage: "checkmark.seal") }
       }
    }
}

public struct NavigationIos: View {
    @State private var showAddView = false
    @EnvironmentObject var sheetData: AddSheetData
    @EnvironmentObject var alertData: DeleteAlert
    @Environment(\.managedObjectContext) private var viewContext

    public init() {}

    public var body: some View {
        NavigationView() {
            BookOverview()
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarTrailing, content: {
                       EditButton()
                    })

                    ToolbarItemGroup(placement: .navigationBarTrailing, content: {
                        Button(action: {
                                self.sheetData.selectedSheet = .AddBook
                                self.sheetData.isOpen.toggle()
                        }) {
                            Label("Add Item", systemImage: "plus")
                        }
                    })
                })
                .navigationBarTitle("Booer")
        }
        .alert(isPresented: self.$alertData.show, content: self.alertData.getAlert)
        .navigationViewStyle(StackNavigationViewStyle())
        .sheet(isPresented: self.$sheetData.isOpen, content: {
            if sheetData.selectedSheet == .AddBook {
                AddView(isOpen: self.$showAddView)
            } else if sheetData.selectedSheet == .AddChallenge {
                AddChallengeMobile(isOpen: self.$showAddView)
                    .environmentObject(alertData)
            } else if sheetData.selectedSheet == .AddLibary {
                AddViewLibary()
            }
        })
//
    }
}
