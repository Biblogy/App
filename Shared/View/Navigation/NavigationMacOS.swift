//
//  NavigationMacOS.swift
//  EBookTracking
//
//  Created by Veit Progl on 01.12.20.
//

import SwiftUI

struct NavigationMac: View {
    @State private var showAddView = false
    @EnvironmentObject var sheetData: AddSheetData
    @EnvironmentObject var alertData: DeleteAlert
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        VStack() {
            NavigationView() {
                Sidebar()
                
                ContentView()
            }
            .sheet(isPresented: self.$sheetData.isOpen, content: {
                if sheetData.selectedSheet == .AddBook {
                    AddView(isOpen: self.$sheetData.isOpen)
                } else if sheetData.selectedSheet == .AddChallenge {
                    AddChallenge(isOpen: self.$sheetData.isOpen)
                }
            })
            .alert(isPresented: self.$alertData.show, content: {
                let primaryButton = Alert.Button.default(Text("Do it")) {
                    viewContext.delete(self.alertData.item!)
                    
                    do {
                        try viewContext.save()
                    } catch {
                        // Replace this implementation with code to handle the error appropriately.
                        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                        let nsError = error as NSError
                        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                    }
                }
                let secondaryButton = Alert.Button.cancel(Text("Please not")) {
                    print("secondary button pressed")
                }
                return Alert(title: Text("Sure ?"), message: Text("Do you want to delete the \(self.alertData.type): \(self.alertData.objectName)"), primaryButton: primaryButton, secondaryButton: secondaryButton)
            })
        }
    }
}
