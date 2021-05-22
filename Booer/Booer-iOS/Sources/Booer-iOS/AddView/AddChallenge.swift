//
//  AddChallenge.swift
//  EBookTracking (iOS)
//
//  Created by Veit Progl on 06.12.20.
//

import SwiftUI
import Combine
import Booer_Shared

public struct AddChallengeMobile: View {
    @Binding var isOpen: Bool
    
    @ObservedObject var data = ChallengeData(bookTitle: "select a book")
    @Environment(\.managedObjectContext) private var viewContext

    public init(isOpen: Binding<Bool>) {
        self._isOpen = isOpen
    }
    
    public var body: some View {
        NavigationView() {
            VStack() {
                Text("I will read")
                    .font(.title).bold()
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
                daysTextField(data: data)
                bookPicker(data: data)
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
                        data.validatingData()
                        if !data.isNotValid {
                            data.addChallenge(context: viewContext)
                        } else {
                            
                        }
                    }, label: {
                        Text("Add")
                    })
                }
            })
            .padding([.leading, .trailing], 20)
        }
    }
}

//struct AddChallenge_Previews: PreviewProvider {
//    @State private var isOpen = true
//    static var previews: some View {
//        AddChallenge(isOpen: self.$isOpen)
//    }
//}
